
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package plateau 
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Plateau extends MovieClip 
	{
		
		public function Plateau() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			var c:Cell;
			
			var i:int;
			var j:int;
			var n:int = 10;
			for ( i; i < n; i++ )
			{				
				for ( j; j < n; j++ )
				{
					c = new Cell();
					c.x = c.width * j;
					c.y = c.width * i;
					cnt.addChild( c );
				}
				j = 0;
			}
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}