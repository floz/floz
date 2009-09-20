
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	public class Thread extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _reference:DisplayObjectContainer;
		private var _threadFunction:Function;
		private var _threadObject:Object;
		
		private var _thread:Sprite;
		
		private var _startTime:int;
		private var _diff:int;
		
		private var _mouseEvent:Boolean;
		private var _keyEvent:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var renderReduction:int = 10;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Thread( reference:DisplayObjectContainer, threadFunction:Function, threadObject:Object ) 
		{
			if ( !reference.parent ) throw new Error( "The 'reference' param must been added to stage." );
			
			this._reference = reference;
			this._threadFunction = threadFunction;
			this._threadObject = threadObject;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onFrame(e:Event):void 
		{
			_startTime = getTimer();
			var itp:Number = Math.floor( 1000 / _thread.stage.frameRate );
			_diff = _startTime + itp;
			
			_thread.stage.invalidate();
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			_mouseEvent = true;
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			_keyEvent = true;
		}
		
		private function onRender(e:Event):void 
		{
			if ( _mouseEvent || _keyEvent )	_diff -= renderReduction;
			
			while ( getTimer() < _diff )
			{
				if ( !_threadFunction.apply( _threadObject ) )
				{
					if ( !_thread.parent ) 
						return;
					
					_reference.stage.removeEventListener( Event.ENTER_FRAME, onFrame );
					_reference.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
					_reference.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
					_reference.removeChild( _thread );
					
					_thread.removeEventListener( Event.RENDER, onRender );
					
					dispatchEvent( new Event( Event.COMPLETE ) );
				}
			}
			
			_mouseEvent = 
			_keyEvent = false;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			trace( "Thread.init" );
			_reference.stage.addEventListener( Event.ENTER_FRAME, onFrame, false, 100 );
			_reference.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_reference.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			
			_thread = new Sprite();
			_thread.addEventListener( Event.RENDER, onRender, false, 0, true );
			_reference.addChild( _thread );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}