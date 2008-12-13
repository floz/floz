
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package accueil 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import portrait.Portrait;
	
	public class Accueil extends MovieClip
	{
		private var por:Portrait;
		
		public function Accueil() 
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
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function getPortrait():Bitmap
		{
			return por.getPortrait();
		}
		
	}
	
}