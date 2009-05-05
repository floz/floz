
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import fl.controls.ComboBox;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;
	import fr.minuit4.utils.UBit;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class MapZoomHolder extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const HIDE:String = "mapzoomholder_hide";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _px:Number;
		private var _py:Number;
		private var _p0x:Number;
		private var _p0y:Number;
		private var _pucesList:Dictionary;
		
		private var _cntPuces:Sprite;
		private var _zoomMap:Bitmap;
		
		private var _display:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cntZoom:Sprite;
		public var cntMask:Sprite;
		public var mapStrk:Sprite;
		public var background:Sprite;
		public var zClose:SimpleButton;
		private var _tooltip:ToolTip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MapZoomHolder() 
		{
			_px = this.width * .5;
			_py = this.height * .5;
			
			_pucesList = new Dictionary();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
			zClose.addEventListener( MouseEvent.CLICK, onCloseClick );
		}
		
		private function onCloseClick(e:MouseEvent):void 
		{
			hide();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			if ( e.target is SimpleButton || e.target is ComboBox ) return;
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			_cntPuces.visible = 
			_tooltip.visible = 
			Model.mainTooltipVisible = false;
			
			_p0x = ( e.stageX - 77.5 ) - cntZoom.x;
			_p0y = ( e.stageY - 141 ) - cntZoom.y;
		}
		
		private function onMove(e:MouseEvent):void 
		{
			cntZoom.x = ( e.stageX - 77.5 ) - _p0x;
			cntZoom.y = ( e.stageY - 141 ) - _p0y;
			
			e.updateAfterEvent();
		}
		
		private function onUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
			_cntPuces.visible = true;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function setPucesStatus():void
		{
			var n:int = _cntPuces.numChildren;
			for ( var i:int; i < n; ++i )
				MovieClip( _cntPuces.getChildAt( i ) ).gotoAndStop( "deselect" );
			
			_pucesList[ Model.currentItem ].gotoAndPlay( "select" );
			Model.currentPuce = _pucesList[ Model.currentItem ];
		}
		
		private function generatePuces():void
		{
			var ct:ColorTransform;
			var puce:Puce;
			var j:int;
			var m:int;
			var n:int = Model.datas.length;
			for ( var i:int; i < n; ++i )
			{
				ct = new ColorTransform();
				ct.color = Model.colors[ i ];
				m = Model.datas[ i ].datas.length;
				for ( j = 0; j < m; ++j )
				{
					puce = new Puce();
					puce.x = Model.datas[ i ].datas[ j ].coordX * 1.5;
					puce.y = Model.datas[ i ].datas[ j ].coordY * 1.5;
					puce.setInfos( Model.datas[ i ].datas[ j ] );
					puce.transform.colorTransform = ct;
					_cntPuces.addChild( puce );
					
					_pucesList[ Model.datas[ i ].datas[ j ] ] = puce;
				}
			}
		}
		
		private function onZoomFinish():void
		{
			_tooltip.show( _pucesList[ Model.currentItem ], true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			_cntPuces = new Sprite();
			
			generatePuces();
			
			_zoomMap = new Bitmap( Model.map, PixelSnapping.AUTO, true );
			_zoomMap.x = -1 * ( _zoomMap.width * 1.5 ) * .5;
			_zoomMap.y = -1 *( _zoomMap.height * 1.5 ) * .5;
			_zoomMap.scaleX = _zoomMap.scaleY = 1.5;
			cntZoom.addChild( _zoomMap );
			
			cntZoom.addChild( _cntPuces );
			
			_cntPuces.useHandCursor = true;
			_cntPuces.buttonMode = true;
			
			_tooltip = new ToolTip();
			addChild( _tooltip );
			_tooltip.setCloseButtonVisible();
		}
		
		public function zoom():void
		{
			setPucesStatus();
			
			cntZoom.x = _px - Model.currentItem.coordX * 1.5;
			cntZoom.y = _py - Model.currentItem.coordY * 1.5;
			
			_tooltip.x = _px - _tooltip.width * .5;
			_tooltip.y = _py - 20;
			Model.mainTooltipVisible = true;
			
			this.alpha = 0;
			this.visible = true;
			
			TweenLite.to( this, .4, { alpha: 1, ease: Quad.easeOut, onComplete: onZoomFinish } );
			_display = true;
		}
		
		public function hide():void
		{
			if ( _tooltip.visible ) _tooltip.visible = false;
			
			TweenLite.to( this, .2, { alpha: 0, ease: Quad.easeOut } );
			_display = false;
			
			dispatchEvent( new Event( MapZoomHolder.HIDE, true ) );
		}
		
		public function centerZoom():void
		{
			var n:int = _cntPuces.numChildren;
			for ( var i:int; i < n; ++i )
				MovieClip( _cntPuces.getChildAt( i ) ).gotoAndStop( "deselect" );
			
			cntZoom.x = 
			cntZoom.y = 0;
			
			this.alpha = 0;
			this.visible = true;
			
			TweenLite.to( this, .4, { alpha: 1, ease: Quad.easeOut } );
			_display = true;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get display():Boolean { return _display; }
		
	}
	
}