
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.flags 
{
	
	public class Flag
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const FREE:Flag = new Flag( 0x000000, "free" );
		public static const UNWALKABLE:Flag = new Flag( 0x000001, "unwalkable" );
		
		public var value:int;
		public var name:String;
		
		// - CONSTRUCTOR ----------------------------------------------------------------- 
		
		public function Flag( value:int, name:String ) 
		{
			this.value = value;
			this.name = name;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getStateByValue( value:int ):Flag
		{
			switch( value )
			{
				case Flag.FREE.value: return Flag.FREE; break;
				case Flag.UNWALKABLE.value: return Flag.UNWALKABLE; break;
				default: return Flag.FREE; break;
			}
		}
		
		public static function getStateByName( name:String ):Flag
		{
			switch( name )
			{
				case Flag.FREE.name: return Flag.FREE; break;
				case Flag.UNWALKABLE.name: return Flag.UNWALKABLE; break;
				default: return Flag.FREE; break;
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