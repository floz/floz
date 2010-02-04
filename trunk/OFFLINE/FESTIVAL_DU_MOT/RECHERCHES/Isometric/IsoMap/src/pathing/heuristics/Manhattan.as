
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pathing.heuristics 
{
	import maps.core.Node;
	
	public class Manhattan implements IHeuristic
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Manhattan() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getCost( a:Node, b:Node ):Number
		{
			var dx:Number = a.x - b.x;
			var vx:Number = dx < 0 ? -dx : dx;
			
			var dy:Number = a.y + b.y;
			var vx:Number = dy < 0 ? -dy : dy;
			
			return dx + dy;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}