
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emagicien.teams 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class TeamsEvent extends Event 
	{
		public static const TEAM_ENCOUNTER:String = "teamsevent_team_encounter";
		public var teamRect:Rectangle;
		
		public function TeamsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new TeamsEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TeamsEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}