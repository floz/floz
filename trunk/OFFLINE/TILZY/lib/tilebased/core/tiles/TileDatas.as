
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.tiles 
{
	import fr.minuit4.games.tilebased.core.flags.Flag;
	
	public class TileDatas 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var x:int;
		public var y:int;
		
		public var flag:int = Flag.FREE.value;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TileDatas( x:int, y:int, flag:int = 0 ) 
		{
			this.x = x;
			this.y = y;
			this.flag = flag;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function toString():String
		{
			return "TileDatas [ x: " + x + ", y: " + y + ", flag : " + flag + " ] ";
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get walkable():Boolean
		{
			return !( flag & Flag.UNWALKABLE.value );
		}
		
		public function set walkable( value:Boolean ):void
		{
			if ( value == walkable ) return;
			
			if ( true == value )
				flag -= Flag.UNWALKABLE.value; // On enlève le status Unwalkable, donc walkable = true;
			else 
				flag |= Flag.UNWALKABLE.value; // On ajoute le status Unwalkable, donc walkable = false;
		}
		
	}
	
}