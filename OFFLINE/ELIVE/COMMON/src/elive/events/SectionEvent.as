
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.events 
{
	import flash.events.Event;
	
	public class SectionEvent extends Event 
	{
		public static const SWITCH_SECTION:String = "sectionevent_switch_section";
		
		public var sectionId:int;
		public var id:int;
		
		public function SectionEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false, sectionId:int = 0, id:int = -1 ) 
		{ 
			this.sectionId = sectionId;
			this.id = id;
			
			super(type, bubbles, cancelable);		
		} 
		
		public override function clone():Event 
		{ 
			return new SectionEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SectionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}