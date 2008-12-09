
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MenuCtrl extends MovieClip
	{
		public var sexeH:SexeItem;
		public var sexeF:SexeItem;
		public var item0:MenuItem;
		public var item1:MenuItem;
		public var item2:MenuItem;
		public var item3:MenuItem;
		public var item4:MenuItem;
		public var item5:MenuItem;
		
		public function MenuCtrl() 
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
			
			item0
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}