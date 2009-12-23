
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.geom 
{
	import flash.geom.Point;
	
	public class CurveBezier 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var start:Point;
		public var end:Point;
		public var control:Point;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function CurveBezier( start:Point, control:Point, end:Point  ) 
		{
			if ( !start || !control || !end ) throw new Error( "Les paramètres de CurveBezier ne peuvent pas être nul." );
			
			this.start = start;
			this.end = end;
			this.control = control;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Renvoie un objet Vector d'objet CurveBezier.
		 * @return	Vector.<CurveBezier>
		 */
		public function subdivide():Vector.<CurveBezier>
		{
			var points:Vector.<Point> = subdivideInPoints();
			
			var curves:Vector.<CurveBezier> = new Vector.<CurveBezier>( 2, true );
			curves[ 0 ] = new CurveBezier( points[ 0 ], points[ 1 ], points[ 2 ] );
			curves[ 1 ] = new CurveBezier( points[ 2 ], points[ 3 ], points[ 4 ] );
			
			return curves;
		}
		
		/**
		 * Renvoie un object Vector d'objet Point.
		 * @return	Vector.<Point>
		 */
		public function subdivideInPoints():Vector.<Point>
		{
			var points:Vector.<Point> = new Vector.<Point>( 5, true );
			
			var p1:Point = new Point( ( control.x + start.x ) * .5, ( control.y + start.y ) * .5 );
			var p2:Point = new Point( ( end.x + control.x ) * .5, ( end.y + control.y ) * .5 );
			var p3:Point = new Point( ( p1.x + p2.x ) * .5, ( p1.y + p2.y ) * .5 );
			
			//		   Solution 1 :			               Solution 2 :
			points[ 0 ] = start; // start   / ----        			 ||	moveTo
			points[ 1 ] = p1;    // control / ----        			 || lineTo
			points[ 2 ] = p3;	 // end		/ start       			 || ----
			points[ 3 ] = p2;    // ----    / control     			 || lineTo
			points[ 4 ] = end;   // ----    / end         			 || lineTo
			
			return points;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/**
		 * Retourne la longueur correcte de la courbe de bezier.
		 * Credit : http://segfaultlabs.com/graphics/qbezierlen/
		 */
		public function get length():Number
		{
			var dax:Number = 2 * control.x;
			var day:Number = 2 * control.y;
			
			var ax:Number = start.x - dax + end.x;
			var ay:Number = start.y - day + end.y;
			var bx:Number = dax - 2 * start.x;
			var by:Number = day - 2 * start.y;
			
			var a:Number = 4 * ( ax * ax + ay * ay );
			var b:Number = 4 * ( ax * bx + ay * by );
			var c:Number = bx * bx + by * by;
			
			var sAbc:Number = 2 * Math.sqrt( a + b + c );
			var a2:Number = Math.sqrt( a );
			var a32:Number = 2 * a * a2;
			var c2:Number = 2 * Math.sqrt( c );
			var ba:Number = b / a2;
			
			return (a32 * sAbc + a2 * b * (sAbc - c2) + (4 * c * a - b * b) * Math.log((2 * a2 + ba + sAbc) / (ba + c2))) / (4 * a32);
		}
		
	}
	
}