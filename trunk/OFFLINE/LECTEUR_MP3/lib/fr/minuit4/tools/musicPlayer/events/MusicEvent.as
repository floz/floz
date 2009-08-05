
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.events 
{
	import flash.events.Event;
	
	public class MusicEvent extends Event 
	{
		
		public function MusicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MusicEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MusicEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}