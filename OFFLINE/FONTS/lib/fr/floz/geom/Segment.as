
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.geom 
{
	import flash.geom.Point;
	
	public class Segment 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var start:Point;
		public var end:Point;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Segment( start:Point, end:Point ) 
		{
			this.start = start;
			this.end = end;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function subdivide( count:int ):Vector.<Point>
		{
			return null
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get length():Number
		{
			return end.subtract( start ).length;
		}
		
	}
	
}