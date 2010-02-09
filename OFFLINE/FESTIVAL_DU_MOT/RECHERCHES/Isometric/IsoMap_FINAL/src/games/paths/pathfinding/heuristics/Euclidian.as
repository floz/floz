
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.paths.pathfinding.heuristics 
{
	
	public class Euclidian implements IHeuristic
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dx:Number;
		private var _dy:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Euclidian() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getCost( x1:int, y1:int, x2:int, y2:int ):Number
		{
			_dx = x1 - x2;
			_dy = y1 - y2;
			return Math.sqrt( _dx * _dx + _dy * _dy );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}