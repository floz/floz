package painting.events 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import painting.interfaces.IBrushManager;
	
	/**
	 * ...
	 * @author Floz
	 */
	public class PaintingEvent extends Event 
	{
		public static const BRUSH_COMPLETE:String = "paintingevent_brushcomplete";
		public static const DRAW:String = "paintingevent_draw";
		
		public var brushHolder:IBrushManager;
		public var instance:Sprite;
		
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