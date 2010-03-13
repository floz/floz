
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.geom 
{
	
	public class IntPoint 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var x:int;
		public var y:int;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IntPoint( x:int = 0, y:int = 0 ) 
		{
			this.x = x;
			this.y = y;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function distance( p1:IntPoint, p2:IntPoint ):int
		{
			var tx:int = p2.x - p1.x;
			var ty:int = p2.y - p1.y;
			
			return Math.sqrt( tx * tx + ty * ty );
		}
		
		public static function interpolate( p1:IntPoint, p2:IntPoint, f:Number ):IntPoint
		{
			if ( f <= 0 )
				return p1;
			
			if ( f >= 1 )
				return p2;
			
			var tx:Number = ( p2.x - p1.x ) * f + p1.x;
			var ty:Number = ( p2.y - p1.y ) * f + p2.y;
			
			return new IntPoint( tx, ty );
		}
		
		public function add( p:IntPoint ):IntPoint
		{
			var tx:int = x + p.x;
			var ty:int = y + p.y;
			
			return new IntPoint( tx, ty );
		}
		
		public function substract( p:IntPoint ):IntPoint
		{
			var tx:int = x - p.x;
			var ty:int = y - p.y;
			
			return new IntPoint( tx, ty );
		}
		
		public function equals( toCompare:IntPoint ):Boolean
		{
			return ( x == toCompare.x && y == toCompare.y );
		}
		
		public function clone():IntPoint
		{
			return new IntPoint( x, y );
		}
		
		public function toString():String
		{
			return "IntPoint :: [ x: " + x + ", y: " + y + " ];";
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get length():Number 
		{
			return Math.sqrt( x * x + y * y );
		}
		
	}
	
}