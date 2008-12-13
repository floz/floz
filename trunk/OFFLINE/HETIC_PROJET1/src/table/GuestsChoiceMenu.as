
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
	
	public class GuestsChoiceMenu extends MovieClip
	{
		public var zLeft:SimpleButton;
		public var zRight:SimpleButton;
		public var cnt:MovieClip;
		
		public function GuestsChoiceMenu() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			zLeft.addEventListener( MouseEvent.CLICK, onClick );
			zRight.addEventListener( MouseEvent.CLICK, onClick );
			
			visible = false;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				
			}
		}
		
		// PRIVATE
		
		private function setButtonStatus():void
		{
			
		}
		
		// PUBLIC
		
		public function show():void
		{
			visible = true;
		}
		
		public function hide():void
		{
			visible = false;
		}
		
	}
	
}