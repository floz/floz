
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
		
		public static const ELIVE_STATUS_CHANGE:String = "elive_status_change";
		
		public var newStatus:String;
		
		public function EliveEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false, newStatus:String = null ) 
		{ 
			this.newStatus = newStatus;			
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