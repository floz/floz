
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class ListeVignettes extends MovieClip 
	{
		public var strk:MovieClip;
		public var cnt:MovieClip;
		
		private var section:String = "works";
		
		public function ListeVignettes() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onAddedToStage(e:Event):void 
		{
			strk.visible = false;
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}