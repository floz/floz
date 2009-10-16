
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.events 
{
	import flash.events.Event;
	
	public class EliveEvent extends Event 
	{
		public static const RUBRIQUE_CHANGE:String = "elive_rubrique_change";
		
		public function EliveEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new EliveEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EliveEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}