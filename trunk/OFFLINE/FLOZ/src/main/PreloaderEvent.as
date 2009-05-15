package main 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Floz
	 */
	public class PreloaderEvent extends Event 
	{
		public static const CHANGE:String = "preloaderevent_change";
		public static const PROGRESS:String = "preloaderevent_progress";
		
		public var percent:Number;
		
		public function PreloaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, percent:Number = -1 ) 
		{ 
			this.percent = percent;
			
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new PreloaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PreloaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}