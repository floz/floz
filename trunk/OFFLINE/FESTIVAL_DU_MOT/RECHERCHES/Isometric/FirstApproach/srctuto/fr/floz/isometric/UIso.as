
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric 
{
	import flash.geom.Point;
	
	public class UIso 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const Y_CORRECT:Number = Math.cos( -Math.PI / 6 ) * Math.SQRT2;
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function isoToScreen( p:Point3D ):Point
		{
			var sx:Number = p.x - p.z;
			var sy:Number = p.y * Y_CORRECT + ( p.x + p.z ) * .5;
			
			return new Point( sx, sy );
		}
		
		public static function screenToIso( p:Point ):Point3D
		{
			var x:Number = p.y + p.x * .5;
			var y:Number = 0;
			var z:Number = p.y - p.x * .5;
			
			return new Point3D( x, y, z );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}