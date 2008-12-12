
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Table extends MovieClip 
	{
		private var datas:Datas;
		
		public function Table() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			datas.removeEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			datas = new Datas( "xml/invites.xml" );
			datas.addEventListener( Event.COMPLETE, onLoadComplete );
			datas.load();
		}
		
		private function onLoadComplete(e:Event):void 
		{
			trace ( datas.getInfos() );
		}
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}