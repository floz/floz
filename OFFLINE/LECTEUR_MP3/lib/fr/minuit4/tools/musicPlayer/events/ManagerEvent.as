
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.events 
{
	import flash.events.Event;
	
	public class ManagerEvent extends Event 
	{
		
		public function ManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}