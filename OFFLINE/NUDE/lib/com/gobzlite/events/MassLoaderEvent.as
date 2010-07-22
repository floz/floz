package com.gobzlite.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public class MassLoaderEvent extends Event 
	{
		public static const PROGRESS:String = "massloader_progress";
		
		private var _percent:Number;
		
		public function MassLoaderEvent(type:String, percent:Number, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_percent = percent;
		} 
		
		public override function clone():Event 
		{ 
			return new MassLoaderEvent(type,_percent, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MassLoaderEvent", "type", "percent", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get percent():Number { return _percent; }
		
	}
	
}