package elive.events 
{
	import elive.navigation.NavIds;
	import flash.events.Event;
	
	public class NavEvent extends Event 
	{
		public static const SWITCH_RUBRIQUE:String = "navevent_switch_rubrique";
		public static const SWITCH_SECTION:String = "navevent_switch_section";
		
		public var navId:String = NavIds.NONE;
		public var sectionId:int = -1;
		public var id:int = -1;
		
		public function NavEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false, rubId:String = null, sectionId:int = 0, id:int = -1 ) 
		{ 
			this.navId = navId;
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