package elive.events 
{
	import flash.events.Event;
	
	public class NavEvent extends Event 
	{
		public static const RUBRIQUE_CHANGE:String;
		
		public var rubId:String;
		
		public function NavEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false, rubId:String = null ) 
		{ 
			super(type, bubbles, cancelable);
			this.rubId = rubId;
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