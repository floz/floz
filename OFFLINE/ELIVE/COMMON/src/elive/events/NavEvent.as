package elive.events 
{
	import flash.events.Event;
	
	public class NavEvent extends Event 
	{
		public static const SWITCH_RUBRIQUE:String = "navevent_switch_rubrique";
		
		public var rubId:String;
		public var sectionId:int;
		public var id:int;
		
		public function NavEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false, rubId:String = null, sectionId:int = 0, id:int = -1 ) 
		{ 
			this.rubId = rubId;
			this.sectionId = sectionId;
			this.id = id;
			
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