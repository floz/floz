package com.isoo.utils
{
	import flash.geom.Point;
	import com.isoo.geom.Point3D;
	import com.isoo.map.Tile;
	
	public class IsoUtils
	{
		// a more accurate version of 1.2247...
		
		/**
		 * Convert case in x y
		 * @param	pos
		 * @return
		 */
		public static function isoToScreen(x:Number, y:Number, z:Number=0):Point
		{
			var screenX:Number = ( x - y ) * Tile.Width * .5; 
			var screenY:Number = ( x + y ) * Tile.Height * .5;
		
			return new Point(screenX, screenY);
		}
		
		public static function screenToIso(x:Number, y:Number):Point3D
		{
			//x = x - Math.ceil( 10 * .5 * Tile.Width);
			
			var normalY:Number = (2 * y - x);
			var normalX:Number = (x + normalY / 2) * 2;
			
			var caseX:int = Math.floor(normalX / Tile.Width) ;
			var caseY:int = Math.floor(normalY / Tile.Width) ;

			var zpos:Number = 0;
			return new Point3D(caseX, caseY, zpos);
		}
	}
}