
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class SexeItem extends MovieClip
	{
		
		public function SexeItem() 
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
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}