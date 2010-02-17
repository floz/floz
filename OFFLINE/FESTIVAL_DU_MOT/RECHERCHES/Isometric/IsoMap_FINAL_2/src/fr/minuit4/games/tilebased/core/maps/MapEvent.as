
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.maps 
{
	import flash.events.Event;
	
	public class MapEvent extends Event 
	{
		public static const INITIALIZED:String = "mapevent_initialiazed";
		
		public function MapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new MapEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MapEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}