
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.geom 
{
	import flash.geom.Point;
	
	public class IsoMath 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		public static const Y_CORRECT:Number = Math.cos( -Math.PI / 6 ) * Math.SQRT2;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoMath() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function screenToIso( p:Point ):Point3D
		{
			var sx:Number = p.x - p.z;
			var sy:Number = p.y * Y_CORRECT + ( p.x + p.z ) * .5;
			
			return new Point( sx, sy );
		}
		
		public static function isoToScreen( p:Point3D ):Point
		{
			var x:Number = p.y + p.x * .5;
			var y:Number = 0;
			var z:Number = p.y - p.x * .5;
			
			return new Point3D( x, y, z );
		}
		
		public static function getDepth( p:Point3D ):Number
		{
			return ( ( p.x + p.z ) * .866 - p.y * .707 );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}