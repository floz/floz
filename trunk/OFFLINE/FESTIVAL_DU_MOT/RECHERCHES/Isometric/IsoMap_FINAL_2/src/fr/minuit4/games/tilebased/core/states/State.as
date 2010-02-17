
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
		public static const UNWALKABLE:State = new State( 0x000002, "unwalkable" );
		
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
		
		public static function getStateByValue( value:int ):State
		{
			switch( value )
			{
				case State.FREE.value: return State.FREE; break;
				case State.UNWALKABLE.value: return State.UNWALKABLE; break;
				default: return State.FREE; break;
			}
		}
		
		public static function getStateByName( name:String ):State
		{
			switch( name )
			{
				case State.FREE.name: return State.FREE; break;
				case State.UNWALKABLE.name: return State.UNWALKABLE; break;
				default: return State.FREE; break;
			}
		}
		
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