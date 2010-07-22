package com.gobzlite.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public class SoundManagerEvent extends Event 
	{
		
		public function SoundManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SoundManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SoundManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}