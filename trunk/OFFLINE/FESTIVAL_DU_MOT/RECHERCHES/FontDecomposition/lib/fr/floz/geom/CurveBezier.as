
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
		public function breakInCurves():Vector.<CurveBezier>
		{
			var points:Vector.<Point> = breakInPoints();
			
			var p:Point = new Point( ( points[ 1 ].x + points[ 2 ].x ) * .5, ( points[ 1 ].y + points[ 2 ].y ) * .5 );
			
			var curves:Vector.<CurveBezier> = new Vector.<CurveBezier>( 2, true );
			curves[ 0 ] = new CurveBezier( points[ 0 ], points[ 1 ], p );
			curves[ 1 ] = new CurveBezier( p, points[ 2 ], points[ 3 ] );
			
			return curves;
		}
		
		/**
		 * Renvoie un object Vector d'objet Point.
		 * @return	Vector.<Point>
		 */
		public function breakInPoints():Vector.<Point>
		{
			var points:Vector.<Point> = new Vector.<Point>( 4, true );
			
			var p1:Point = new Point( ( control.x + start.x ) * .5, ( control.y + start.y ) * .5 );
			var p2:Point = new Point( ( end.x + control.x ) * .5, ( end.y + control.y ) * .5 );
			
			points[ 0 ] = start; // moveTo
			points[ 1 ] = p1;    // lineTo
			points[ 2 ] = p2;    // lineTo
			points[ 3 ] = end;   // lineTo
			
			return points;
		}
		
		public function divideInPoints( divisions:int ):Vector.<Point>
		{
			if ( divisions == 0 )
			{
				var v:Vector.<Point> = new Vector.<Point>( 3, true );
				v[ 0 ] = this.start;
				v[ 1 ] = this.control;
				v[ 2 ] = this.end;
				
				return v;
			}
			if ( divisions == 1 ) return breakInPoints();
			
			var j:int, m:int, k:int, l:int;
			var tmp1:Vector.<CurveBezier>, tmp2:Vector.<CurveBezier>;
			var curves:Vector.<CurveBezier> = breakInCurves();		
			for ( var i:int = 1; i < divisions; ++i )
			{
				tmp1 = new Vector.<CurveBezier>();
				
				m = curves.length;
				for ( j = 0; j < m; ++j )
					tmp1.push( curves[ j ] );
				
				curves = new Vector.<CurveBezier>();
				m = tmp1.length;
				for ( j = 0; j < m; ++j )
				{
					tmp2 = tmp1[ j ].breakInCurves();
					l = tmp2.length;
					for ( k = 0; k < l; ++k )
						curves.push( tmp2[ k ] );
				}
			}
			
			var points:Vector.<Point> = new Vector.<Point>();
			m = curves.length;
			
			points[ 0 ] = curves[ 0 ].start;			
			for ( i = 0; i < m; ++i )
				points.push( curves[ i ].control );
			
			points.push( curves[ int( i - 1 ) ].end );
			
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