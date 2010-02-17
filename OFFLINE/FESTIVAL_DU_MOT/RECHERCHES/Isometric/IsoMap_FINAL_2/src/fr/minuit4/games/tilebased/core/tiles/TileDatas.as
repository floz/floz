
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.tiles 
{
	import fr.minuit4.games.tilebased.core.states.State;
	
	public class TileDatas 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var x:int;
		public var y:int;
		
		public var g:Number = 0;
		public var f:Number = 0;
		
		public var flag:int = State.FREE;
		
		public var parent:TileDatas;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TileDatas() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get walkable():Boolean
		{
			return !( flag & State.UNWALKABLE.value );
		}
		
		public function set walkable( value:Boolean ):void
		{
			if ( value == walkable ) return;
			
			if ( true == value )
				flag -= State.UNWALKABLE.value; // On enlève le status Unwalkable, donc walkable = true;
			else 
				flag |= State.UNWALKABLE.value; // On ajoute le status Unwalkable, donc walkable = false;
		}
		
	}
	
}