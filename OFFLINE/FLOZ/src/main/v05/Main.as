
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		public var partsInfos:PartsInfos;
		
		public function Main() 
		{
			partsInfos.addEventListener( PartsInfos.ADD_CLICK, onAddClick );
			partsInfos.addEventListener( PartsInfos.DELETE_CLICK, onDeleteClick );
		}
		
		// EVENTS
		
		private function onAddClick(e:Event):void 
		{
			
		}
		
		private function onDeleteClick(e:Event):void 
		{
			
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}