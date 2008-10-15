
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package items.characters 
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Player extends Character 
	{
		
		public function Player() 
		{			
			this.graphics.beginFill( 0x0000FF );
			this.graphics.drawRect( 0, 0, 50, 65 );
			this.graphics.endFill();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			defineActions();
		}
		
		private function onDown(e:KeyboardEvent):void 
		{
			trace ( e.keyCode );
		}
		
		// PRIVATE	
		
		private function defineActions():void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onDown );
		}
		
		// PUBLIC
		
	}
	
}