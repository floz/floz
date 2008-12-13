
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Guest extends MovieClip
	{
		public var cnt:MovieClip;
		
		public function Guest() 
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
			
			this.buttonMode = true;
			
			cnt.addChild( new Bitmap( new Default( 0, 0 ) ) );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}