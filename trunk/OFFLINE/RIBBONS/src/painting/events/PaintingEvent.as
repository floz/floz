package painting.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Floz
	 */
	public class PaintingEvent extends Event 
	{
		
		public function PaintingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new PaintingEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PaintingEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}