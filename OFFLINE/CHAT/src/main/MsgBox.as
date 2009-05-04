
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MsgBox extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _lastMessage:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var message:TextField;
		public var btSend:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MsgBox() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			message.text = "";
			
			btSend.addEventListener( MouseEvent.CLICK, onClick );
			addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if ( e.charCode == 13 )
				onClick( null );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if ( message.text == "" ) return;
			
			_lastMessage = message.text;
			message.text = "";
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getLastMessage():String { return _lastMessage }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}