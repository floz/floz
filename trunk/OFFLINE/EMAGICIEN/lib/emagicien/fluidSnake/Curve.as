
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emagicien.fluidSnake 
{
	import flash.geom.Point;
	
	public class Curve 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Curve() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function begin( px:Number, py:Number, dx:Number, dy:Number, beziersCount:int = 2 ):Vector.<Point>
		{
			if ( beziersCount == 0 ) 
				return new Vector.<Point>( true, 2 )[ new Point( px, py ), new Point( dx, dy ) ];
			
			var n:int = int( beziersCount * 2 + 1 );
			var points:Vector.<Point> = new Vector.<Point>( true, n );
			for ( var i:int; i < n; ++i )
			{
				//points[ i ] = new Point( 
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}