
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class MapZoomHolder extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const HIDE:String = "mapzoomholder_hide";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _px:Number;
		private var _py:Number;
		private var _pucesList:Dictionary;
		
		private var _cntPuces:Sprite;
		private var _zoomMap:Bitmap;
		
		private var _display:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cntZoom:Sprite;
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
			
			zClose.addEventListener( MouseEvent.CLICK, onCloseClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onCloseClick(e:MouseEvent):void 
		{
			hide();
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
					puce.x = Model.datas[ i ].datas[ j ].coordX;
					puce.y = Model.datas[ i ].datas[ j ].coordY;
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
			_zoomMap.x = -_zoomMap.width * .5;
			_zoomMap.y = -_zoomMap.height * .5;
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
			
			cntZoom.x = _px - Model.currentItem.coordX;
			cntZoom.y = _py - Model.currentItem.coordY;
			
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
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get display():Boolean { return _display; }
		
	}
	
}