
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.states 
{
	
	public class State
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const FREE:State = new State( 0x000000, "free" );
		public static const UNWALKABLE:State = new State( 0x000001, "name" );
		
		public var value:int;
		public var name:String;
		
		// - CONSTRUCTOR ----------------------------------------------------------------- 
		
		public function State( value:int, name:String ) 
		{
			this.value = value;
			this.name = name;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function valueOf():int
		{
			return value;
		}
		
		public function toString():String
		{
			return name;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}