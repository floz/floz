
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.scrollbars
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import fr.minuit4.motion.easing.Linear;
	import fr.minuit4.motion.easing.Quad;
	import fr.minuit4.motion.M4Tween;
	
	public class VScrollbar extends Sprite implements IScrollbar
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const BLUR:BlurFilter = new BlurFilter( 0, 0, 3 );
		private const DRAG_RECTANGLE:Rectangle = new Rectangle();
		
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
		private var _finalScrollY:Number;
		private var _finalSliderY:Number;
		
		private var _scrollTarget:DisplayObject;
		private var _scrollRect:Rectangle;
		
		private var _scrollSpeed:Number = 10;
		private var _delta:Number;
		
		private var _scrollTimer:Timer;
		
		private var _background:DisplayObject;
		private var _slider:DisplayObject;
		private var _btUp:DisplayObject;
		private var _btDown:DisplayObject;
		
		private var _enableBlur:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function VScrollbar( background:DisplayObject = null, slider:DisplayObject = null, btUp:DisplayObject = null, btDown:DisplayObject = null, resizeSliderOnResize:Boolean = false ) 
		{
			setBackground( background );
			setSlider( slider );
			setBtUp( btUp );
			setBtDown( btDown );
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
			
			_cntSlider.removeEventListener( MouseEvent.MOUSE_DOWN, handleSliderDown );
			_cntBtUp.removeEventListener( MouseEvent.MOUSE_DOWN, handleButtonDown );
			_cntBtDown.removeEventListener( MouseEvent.MOUSE_DOWN, handleButtonDown );
			
			removeEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		private function handleAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, handleRemovedFromStage );
			
			reorganize( true );
			
			_scrollTimer = new Timer( 200 );
			
			_cntSlider.addEventListener( MouseEvent.MOUSE_DOWN, handleSliderDown, false, 0, true );
			_cntBtUp.addEventListener( MouseEvent.MOUSE_DOWN, handleButtonDown, false, 0, true );
			_cntBtDown.addEventListener( MouseEvent.MOUSE_DOWN, handleButtonDown, false, 0, true );
			
			addEventListener( Event.ENTER_FRAME, handleEnterFrame, false, 0, true );
		}
		
		private function handleSliderDown(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove );
			
			_beginY = e.stageY - ( _cntSlider.y - e.localY );
			setPosMax();
			
			DRAG_RECTANGLE.y = _cntBtUp.height;
			DRAG_RECTANGLE.height = _cntBackground.height - _cntSlider.height + 1;
			_cntSlider.startDrag( false, DRAG_RECTANGLE );
			
			handleMouseMove( e );
		}
		
		private function handleMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove );
			_cntSlider.stopDrag();
			
			_finalSliderY = _cntSlider.y;
		}
		
		private function handleMouseMove(e:MouseEvent):void 
		{
			var position:Number = e.stageY - _beginY;
			if ( position < 0 ) position = 0;
			else if ( position > _posMax ) position = _posMax;
			
			_percentScroll = position / _posMax;
			refresh( false );
		}
		
		private function handleButtonDown(e:MouseEvent):void 
		{			
			var scrollSpeed:Number = _scrollSpeed * .01;
			switch( e.currentTarget )
			{
				case _cntBtUp: _delta = -scrollSpeed; break;
				case _cntBtDown: _delta = scrollSpeed; break;
			}
			
			onScroll();
			
			stage.addEventListener( MouseEvent.MOUSE_UP, handleButtonUp );
			_scrollTimer.addEventListener( TimerEvent.TIMER, handleTimer, false, 0, true );
			_scrollTimer.start();
		}
		
		private function handleTimer(e:TimerEvent):void 
		{
			onScroll();
		}
		
		private function handleButtonUp(e:MouseEvent):void 
		{
			_scrollTimer.stop();
			_scrollTimer.removeEventListener( TimerEvent.TIMER, handleTimer );
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleButtonUp );
		}
		
		private function handleMouseWheel(e:MouseEvent):void 
		{			
			var scrollSpeed:Number = _scrollSpeed * .01;
			if( e.delta > 0 ) _delta = -scrollSpeed;
			else _delta = scrollSpeed;
			
			onScroll();
		}
		
		private function handleEnterFrame(e:Event):void 
		{
			if ( _scrollRect.height != _scrollTarget.height )
			{
				_scrollRect.height = _scrollTarget.height;
				refresh();
			}
			
			if ( int( _scrollRect.y ) != int( _finalScrollY ) )
			{
				_scrollRect.y -= ( _scrollRect.y - _finalScrollY ) * .3;
				_scrollTarget.scrollRect = _scrollRect;
				
				if ( _enableBlur )
				{
					var diff:Number = _finalScrollY - _scrollRect.y;
					diff *= .2;
					BLUR.blurY = diff > 0 ? diff : -diff;
					_scrollTarget.filters = [ BLUR ];
					
					if ( int( _scrollRect.y ) == int( _finalScrollY ) ) _scrollTarget.filters = [];
				}
			}
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
		
		private function refresh( refreshSlider:Boolean = true ):void
		{
			if ( !_scrollTarget ) return;
			
			if( refreshSlider ) _cntSlider.y = _posMax * _percentScroll + _cntBtUp.height;
			_finalScrollY = _posScrollMax * _percentScroll;
		}
		
		private function onScroll():void
		{
			_percentScroll += _delta;
			
			if ( _percentScroll < 0 ) _percentScroll = 0;
			else if ( _percentScroll > 1 ) _percentScroll = 1;
			
			setPosMax();
			refresh();
		}
		
		private function setPosMax():void
		{
			_posMax = _cntBackground.height - _cntSlider.height;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function link( scrollTarget:DisplayObject, scrollRect:Rectangle ):void
		{
			if ( !scrollTarget ) return;
			
			this._scrollTarget = scrollTarget;
			this._scrollRect = scrollRect;
			
			_scrollTarget.scrollRect = _scrollRect;
			_scrollTarget.addEventListener( MouseEvent.MOUSE_WHEEL, handleMouseWheel );
			
			_percentScroll = 0;
			_posScrollMax = ( _scrollTarget.height - _scrollRect.height );
			setPosMax();
			refresh();
		}
		
		public function setBackground( value:DisplayObject ):void
		{
			if ( !value ) return;
			
			if ( !_cntBackground ) _cntBackground = new Sprite();		
			
			while ( _cntBackground.numChildren ) _cntBackground.removeChildAt( 0 );
			
			_background = value;
			_cntBackground.addChild( _background );
		}
		public function getBackground():DisplayObject { return this._background; }
		
		public function setSlider( value:DisplayObject ):void
		{
			if ( !value ) return;
			
			if ( !_cntSlider ) _cntSlider = new Sprite();
			
			while ( _cntSlider.numChildren ) _cntSlider.removeChildAt( 0 );
			
			_slider = value;
			_cntSlider.addChild( _slider );
		}
		public function getSlider():DisplayObject { return this._slider; }
		
		public function setBtUp( value:DisplayObject ):void
		{
			if ( !value ) return;
			
			if ( !_cntBtUp ) _cntBtUp = new Sprite();
			
			while ( _cntBtUp.numChildren ) _cntBtUp.removeChildAt( 0 );
			
			_btUp = value;
			_cntBtUp.addChild( _btUp );
		}
		public function getBtUp():DisplayObject { return _btUp; }
		
		public function setBtDown( value:DisplayObject ):void
		{
			if ( !value ) return;
			
			if ( !_cntBtDown ) _cntBtDown = new Sprite();
			
			while ( _cntBtDown.numChildren ) _cntBtDown.removeChildAt( 0 );
			
			_btDown = value;
			_cntBtDown.addChild( _btDown );
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
		
		public function set enableBlur( value:Boolean ):void
		{
			this._enableBlur = value;
		}
		public function get enableBlur():Boolean { return this._enableBlur; }
		
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
