
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class Confirmation extends MovieClip
	{
		public static const VALIDATION:String = "validation";
		public static const SELECTION:String = "selection";
		public static const YES:String = "yes";
		public static const NO:String = "no";
		
		public var msg:TextField;
		public var zYes:SimpleButton;
		public var zNo:SimpleButton;
		
		private var _state:String;
		
		public function Confirmation() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			zYes.removeEventListener( MouseEvent.CLICK, onClick );
			zNo.removeEventListener( MouseEvent.CLICK, onClick );
			
			this.visible = false;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			zYes.addEventListener( MouseEvent.CLICK, onClick );
			zNo.addEventListener( MouseEvent.CLICK, onClick );
			
			this.visible = false;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zYes: dispatchEvent( new Event( Confirmation.YES ) ); break;
				case zNo: dispatchEvent( new Event( Confirmation.NO ) ); break;
			}
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function show( state:String ):void
		{
			msg.text = "Êtes vous sûr de vouloir valider la table ?";
			
			_state = state;
			this.visible = true;
		}
		
		public function hide():void
		{
			_state = "";
			this.visible = false;
		}
		
		// GETTERS & SETTERS
		
		public function get state():String { return _state; }
		
	}
	
}