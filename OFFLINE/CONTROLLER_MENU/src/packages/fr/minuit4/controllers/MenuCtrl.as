
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package fr.minuit4.controllers 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class MenuCtrl extends EventDispatcher
	{
		public static const SECTION_SELECTED		:String = "section_selected";
		public static const SECTION_OVER			:String = "section_over";
		public static const SECTION_OUT				:String = "section_out";
		
		private var _useHandCursor					:Boolean;
		private var _usePressMode					:Boolean;
		private var _dispatchOverStateWhenPressed	:Boolean;
		private var _sections						:Dictionary;
		private var _numSections					:int;
		
		private var _stage	:Stage;
		
		private var _tempSection	:DisplayObject;
		private var _currentSection	:DisplayObject;
		private var _pressed			:Boolean;
		
		/**
		 * Outil qui permet de controller un menu et les évènements qui lui sont liés. 
		 * 
		 * @param	useHandCursor
		 * @param	usePressMode
		 * @param	dispatchOverStateWhenPressed
		 */
		public function MenuCtrl( useHandCursor:Boolean = true, usePressMode:Boolean = true, dispatchOverStateWhenPressed:Boolean = true ) 
		{
			this._useHandCursor = useHandCursor;
			this._usePressMode = usePressMode;
			this._dispatchOverStateWhenPressed = dispatchOverStateWhenPressed;
			
			_sections = new Dictionary( false );
		}
		
		// EVENTS
		
		private function onClick(e:MouseEvent):void 
		{
			_currentSection = e.currentTarget as DisplayObject;
			dispatchEvent( new Event( MenuCtrl.SECTION_SELECTED ) );
		}
		
		private function onDown(e:MouseEvent):void 
		{
			_stage = DisplayObject( e.currentTarget ).stage;
			if ( !_stage ) 
				return;
			
			_pressed = true;
			_tempSection = e.currentTarget as DisplayObject;
			_stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( _pressed && !_dispatchOverStateWhenPressed ) 
				return;
			
			dispatchEvent( new Event( MenuCtrl.SECTION_OVER ) );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( _pressed && !_dispatchOverStateWhenPressed ) 
				return;
			
			dispatchEvent( new Event( MenuCtrl.SECTION_OUT ) );
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if ( e.target == _tempSection ) 
			{
				_currentSection = _tempSection;
				dispatchEvent( new Event( MenuCtrl.SECTION_SELECTED ) );
			}
			
			_pressed = false;
			_tempSection = null;			
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function linkToMenu( menu:DisplayObjectContainer ):void
		{
			var section:DisplayObject;
			
			var n:int = menu.numChildren;
			for ( var i:int; i < n; i++ )
			{
				section = menu.getChildAt( i );
				if ( !( section is SimpleButton || section is Sprite ) ) 
					continue;
				
				this._sections[ section ] = false;
				this._numSections++;
			}
		}
		
		public function linkToSection( section:DisplayObject ):void
		{			
			this._sections[ section ] = true;
			this._numSections++;
		}
		
		public function activate():void
		{
			var ref:Object;
			for ( ref in _sections )
			{				
				if ( _sections[ ref ] ) 
					continue;
				
				if ( _useHandCursor && ref is Sprite ) 
				{
					Sprite( ref ).buttonMode = true;
					Sprite( ref ).useHandCursor = true;
				}
				
				if ( _usePressMode ) DisplayObject( ref ).addEventListener( MouseEvent.MOUSE_DOWN, onDown );
				else DisplayObject( ref ).addEventListener( MouseEvent.CLICK, onClick );
				DisplayObject( ref ).addEventListener( MouseEvent.MOUSE_OVER, onOver );
				DisplayObject( ref ).addEventListener( MouseEvent.MOUSE_OUT, onOut );
				
				_sections[ ref ] = true;
			}
		}
		
		// GETTERS & SETTERS
		
		public function get currentSection():DisplayObject { return this._currentSection; }		
		public function get numSections():int { return this._numSections; }
		
	}
	
}