
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.flartoolkit.events 
{
	import flash.events.Event;
	
	public class FLARDetectorEvent extends Event 
	{
		public static const MARKER_ADDED:String = "marker_added";
		public static const MARKER_REMOVED:String = "marker_removed";
		
		public var id:int;
		
		public function FLARDetectorEvent(type:String, id:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			this.id = id;
		} 
		
		public override function clone():Event 
		{ 
			return new FLARDetectorEvent(type, id, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FLARDetectorEvent", "id", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}