
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.scrollbar 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Scrollbar extends Sprite implements IScrollbar
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cntBackground:Sprite;
		private var _cntSlider:Sprite;
		
		private var _beginX:Number;
		
		private var _scrollTarget:DisplayObject;
		private var _scrollRect:Rectangle;
		
		private var _scrollSpeed:Number;
		
		private var _background:DisplayObject;
		private var _slider:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Scrollbar() 
		{
			_cntBackground = new Sprite();
			addChild( _cntBackground );
			
			_cntSlider = new Sprite();
			addChild( _cntSlider );
			
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
			
			_cntSlider.addEventListener( MouseEvent.MOUSE_DOWN, handleSliderDown, false, 0, true );
		}
		
		private function handleSliderDown(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove );
		}
		
		private function handleMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleStageUp );
		}
		
		private function handleMouseMove(e:MouseEvent):void 
		{
			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function link( scrollTarget:DisplayObject, scrollRect:Rectangle ):void
		{
			this._displayObject = displayObject;
			this._scrollRect = scrollRect;
		}
		
		public function setScrollSpeed( value:Number ):void
		{
			this._scrollSpeed = value;
		}
		public function getScrollSpeed():Number { return this._scrollSpeed; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set background( value:DisplayObject ):void
		{
			if ( _background ) 
			{
				_cntBackground.removeChild( _background );
				_background = null;
			}
			_background = value;
			_cntBackground.addChild( _background );
		}
		public function get background():DisplayObject { return this._background; }
		
		public function set slider( value:DisplayObject ):void
		{
			if ( _slider ) 
			{
				_cntSlider.removeChild( _slider );
				_slider = null;
			}
			_slider = value;
			_cntSlider.addChild( _slider );
		}
		public function get slider():DisplayObject { return this._slider; }
		
	}
	
}