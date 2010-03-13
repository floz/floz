
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.geom 
{
	import flash.geom.Point;
	
	public class Point3D extends Point
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var z:Number = 0;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Point3D( x:Number = 0, y:Number = 0, z:Number = 0 ) 
		{
			super();
			
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		static public function distance( p1:Point3D, p2:Point3D ):Number
		{
			var tx:Number = p2.x - p1.x;
			var ty:Number = p2.y - p1.y;
			var tz:Number = p2.z - p1.z;
			
			return Math.sqrt( tx * tx + ty * ty + tz * tz );
		}
		
		static public function polar( origin:Point3D, radius:Number, theta:Number = 0):Point3D
		{
			var tx:Number = origin.x + Math.cos( theta ) * radius;
			var ty:Number = origin.y + Math.sin( theta ) * radius;
			var tz:Number = origin.z
			
			return new Point3D( tx, ty, tz );
		}
		
		static public function interpolate( p1:Point3D, p2:Point3D, f:Number ):Point3D
		{
			if (f <= 0)
				return p1;
			
			if (f >= 1)
				return p2;
			
			var tx:Number = (p2.x - p1.x) * f + p1.x;    
			var ty:Number = (p2.y - p1.y) * f + p1.y;    
			var tz:Number = (p2.z - p1.z) * f + p1.z;
			
			return new Point3D( tx, ty, tz );
		}
		
		override public function clone():Point 
		{
			return new Point3D( x, y, z );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function get length():Number
		{
			return Math.sqrt( x * x + y * y + z * z );
		}
		
	}
	
}