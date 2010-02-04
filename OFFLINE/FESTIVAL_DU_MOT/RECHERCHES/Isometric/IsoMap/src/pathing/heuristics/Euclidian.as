
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pathing.heuristics 
{
	import maps.core.Node;
	
	public class Euclidian implements IHeuristic
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Euclidian() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getCost( a:Node, b:Node ):Number
		{
			var dx:Number = a.x - b.x;
			var dy:Number = a.y - d.y;
			return Math.sqrt( dx * dx + dy * dy );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}