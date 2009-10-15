
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.scrollbars
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class VScrollbar extends Sprite implements IScrollbar
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _resizeSliderOnResize:Boolean;
		
		private var _cntBackground:Sprite;
		private var _cntSlider:Sprite;
		private var _cntBtUp:Sprite;
		private var _cntBtDown:Sprite;
		
		private var _beginY:Number;
		private var _posMax:Number;
		private var _percentScroll:Number;
		private var _posScrollMax:Number;
		
		private var _scrollTarget:DisplayObject;
		private var _scrollRect:Rectangle;
		
		private var _scrollSpeed:Number = 2;
		
		private var _background:DisplayObject;
		private var _slider:DisplayObject;
		private var _btUp:DisplayObject;
		private var _btDown:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function VScrollbar( resizeSliderOnResize:Boolean = false ) 
		{
			_resizeSliderOnResize = resizeSliderOnResize;
			
			if ( !_cntBackground ) _cntBackground = new Sprite();
			if ( !_cntSlider ) _cntSlider = new Sprite();
			if ( !_cntBtUp ) _cntBtUp = new Sprite();
			if ( !_cntBtDown ) _cntBtDown = new Sprite();
			
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function handleRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );			
		}
		
		private function handleAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, handleRemovedFromStage );
			
			reorganize( true );
			
			_percentScroll = 0;
			refresh();
			
			_cntSlider.addEventListener( MouseEvent.MOUSE_DOWN, handleSliderDown, false, 0, true );
		}
		
		private function handleSliderDown(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove );
			
			_beginY = e.stageY - ( _cntSlider.y - e.localY );
			_posMax = _cntBackground.height - _cntSlider.height;
			
			handleMouseMove( e );
		}
		
		private function handleMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove );
		}
		
		private function handleMouseMove(e:MouseEvent):void 
		{
			var position:Number = e.stageY - _beginY;
			if ( position < 0 ) position = 0;
			else if ( position > _posMax ) position = _posMax;
			
			_percentScroll = position / _posMax;
			refresh();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function reorganize( instanciate:Boolean = false ):void
		{
			if ( instanciate )
			{
				addChildAt( _cntBackground, 0 );
				addChildAt( _cntSlider, 1 );
				addChild( _cntBtUp );
				addChild( _cntBtDown );
			}
			
			if ( _cntBtUp.height > 0 ) _cntBackground.y = _cntBtUp.height;
			_cntBtUp.y = _cntBackground.y - _cntBtUp.height;
			_cntBtDown.y = _cntBackground.y + _cntBackground.height;
		}
		
		private function refresh():void
		{
			if ( !_scrollTarget ) return;
			
			_cntSlider.y = _posMax * _percentScroll + _btUp.height;
			_scrollRect.y = _posScrollMax * _percentScroll;
			_scrollTarget.scrollRect = _scrollRect;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function link( scrollTarget:DisplayObject, scrollRect:Rectangle ):void
		{
			if ( !scrollTarget ) return;
			
			this._scrollTarget = scrollTarget;
			this._scrollRect = scrollRect;
			
			scrollTarget.scrollRect = scrollRect;
			
			_posScrollMax = ( scrollTarget.height - scrollRect.height );
			refresh();
		}
		
		public function setBackground( value:DisplayObject ):void
		{
			if ( !_cntBackground ) _cntBackground = new Sprite();		
			
			while ( _cntBackground.numChildren ) _cntBackground.removeChildAt( 0 );
			
			_background = value;
			_cntBackground.addChild( _background );
		}
		public function getBackground():DisplayObject { return this._background; }
		
		public function setSlider( value:DisplayObject ):void
		{
			if ( !_cntSlider ) _cntSlider = new Sprite();
			
			while ( _cntSlider.numChildren ) _cntSlider.removeChildAt( 0 );
			
			_slider = value;
			_cntSlider.addChild( _slider );
		}
		public function getSlider():DisplayObject { return this._slider; }
		
		public function setBtUp( value:DisplayObject ):void
		{
			if ( !_cntBtUp ) _cntBtUp = new Sprite();
			
			while ( _cntBtUp.numChildren ) _cntBtUp.removeChildAt( 0 );
			
			_btUp = value;
			_cntBtUp.addChild( _btUp );
			
			reorganize();
		}
		public function getBtUp():DisplayObject { return _btUp; }
		
		public function setBtDown( value:DisplayObject ):void
		{
			if ( !_cntBtDown ) _cntBtDown = new Sprite();
			
			while ( _cntBtDown.numChildren ) _cntBtDown.removeChildAt( 0 );
			
			_btDown = value;
			_cntBtDown.addChild( _btDown );
			
			reorganize();
		}
		public function getBtDown():DisplayObject { return _btDown; }
		
		public function setScrollSpeed( value:Number ):void
		{
			this._scrollSpeed = value;
		}
		public function getScrollSpeed():Number { return this._scrollSpeed; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set resizeSliderOnResize( value:Boolean ):void
		{
			_resizeSliderOnResize = value;
		}
		public function get resizeSliderOnResize():Boolean { return _resizeSliderOnResize; }
		
		override public function set height(value:Number):void 
		{
			if ( !_background ) return;			
			
			var resizeValue:Number = value - _cntBtUp.height - _cntBtDown.height;
			
			if ( _resizeSliderOnResize )
			{
				var percentResize:Number = resizeValue * 100 / _cntBackground.height;
				_cntSlider.height = ( _cntSlider.height * percentResize ) * .01;
			}			
			_cntBackground.height = resizeValue;
			
			reorganize();
		}
		override public function get height():Number { return _cntBackground.height; }
		
		override public function set width( value:Number ):void
		{
			if ( !_background ) return;	
			
			if ( _resizeSliderOnResize )
			{
				var percentResize:Number = value * 100 / _cntBackground.width;
				_cntSlider.width = ( _cntSlider.width * percentResize ) * .01;
			}			
			_cntBackground.width = value;
			
			reorganize();
		}
		
	}
	
}