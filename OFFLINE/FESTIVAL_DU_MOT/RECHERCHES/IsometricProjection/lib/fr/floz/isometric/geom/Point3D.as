
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.geom 
{
	
	public class Point3D 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Point3D( x:Number = 0, y:Number = 0, z:Number = 0 ) 
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function distance( a:Point3D, b:Point3D ):Number 
		{
			var tx:Number = b.x - a.x;
			var ty:Number = b.y - a.y;
			var tz:Number = b.z - a.z;
			
			return Math.sqrt( tx * tx + ty * ty + tz * tz );
		}
		
		public function clone():Point3D
		{
			return new Point3D( x, y, z );
		}
		
		public function toString():String 
		{
			return "Point3D >> x: " + x + ", y:" + y + ", z: " + z;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}