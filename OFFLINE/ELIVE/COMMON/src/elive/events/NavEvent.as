package elive.events 
{
	import flash.events.Event;
	
	public class NavEvent extends Event 
	{
		public static const READY:String;
		public static const RUBRIQUE_CHANGE:String;
		
		public var rubId:String;
		
		public function NavEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new NavEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("NavEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}