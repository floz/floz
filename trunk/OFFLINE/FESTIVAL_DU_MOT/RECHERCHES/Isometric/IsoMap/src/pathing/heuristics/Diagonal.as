
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pathing.heuristics 
{
	import maps.core.Node;
	
	public class Diagonal implements IHeuristic
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const DIAGCOST:Number = Math.SQRT2;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Diagonal() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getCost( a:Node, b:Node ):Number
		{
			var dx:Number = a.x - b.x;
			var vx:Number = dx < 0 ? -dx : dx;
			
			var dy:Number = a.y - b.y;
			var vy:Number = dy < 0 ? -dy : dy;
			
			var diag:Number = dx < dy ? dx : dy;			
			var straight:Number = dx + dy;
			
			return DIAGCOST * diag + ( straight - 2 * diag );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}