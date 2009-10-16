
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.events 
{
	import flash.events.Event;
	
	public class EthingEvent extends Event 
	{
		
		public function EthingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new EthingEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EthingEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}