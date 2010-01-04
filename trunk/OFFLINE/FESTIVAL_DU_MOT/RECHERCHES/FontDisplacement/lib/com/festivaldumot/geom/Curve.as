
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.festivaldumot.geom 
{
	import flash.geom.Point;
	
	public class Curve
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		/** Le point de départ de la courbe. */
		public var start:Point;
		/** Le point de contrôle (bezier) de la courbe. */
		public var control:Point;
		/** Le point de fin de la courbe */
		public var end:Point;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Crée une courbe à partir de 3 points.
		 * @param	start	Point	Le point de départ de la courbe.
		 * @param	control	Point	Le point de contrôle (bezier) de la courbe.
		 * @param	end	Point	Le point de fin de la courbe.
		 */
		public function Curve( start:Point, control:Point, end:Point ) 
		{
			this.start = start;
			this.control = control;
			this.end = end;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Divise la courbe "\/" en deux courbes : "\_" et "_/", l'idée étant d'arriver à "\_/".
		 * @return	Vector.<Curve>	L'objet Vector contenant les deux objets Curve obtenus.
		 */
		public function divideInCurves():Vector.<Curve>
		{
			const points:Vector.<Point> = divide( 1 );
			
			const p:Point = new Point( ( points[ 1 ].x + points[ 2 ].x ) * .5, ( points[ 1 ].y + points[ 2 ].y ) * .5 );
			
			const curves:Vector.<Curve> = new Vector.<Curve>( 2, true );
			curves[ 0 ] = new Curve( points[ 0 ], points[ 1 ], p );
			curves[ 1 ] = new Curve( p, points[ 2 ], points[ 3 ] );
			
			return curves;
		}
		
		/**
		 * Divise la courbe en plusieurs courbes, et renvoie un Vector de Point.
		 * Idéal pour retracer la courbe en plusieurs lineTo.
		 * @param	divisions	uint	Le nombre de fois que la courbe doit subir une division.
		 * @return	Vector.<Point>	L'ensemble des points de la nouvelle courbe.
		 */
		public function divide( divisions:uint ):Vector.<Point>
		{
			var points:Vector.<Point>;
			
			if ( divisions == 0 )
			{
				points = new Vector.<Point>( 3, true );
				points[ 0 ] = this.start;
				points[ 1 ] = this.control;
				points[ 2 ] = this.end;
			}
			else if ( divisions == 1 )
			{
				points = new Vector.<Point>( 4, true );
				
				const p1:Point = new Point( ( control.x + start.x ) * .5, ( control.y + start.y ) * .5 );
				const p2:Point = new Point( ( end.x + control.x ) * .5, ( end.y + control.y ) * .5 );
				
				points[ 0 ] = start;	// moveTo
				points[ 1 ] = p1;		// lineTo
				points[ 2 ] = p2;		// lineTo
				points[ 3 ] = end;		// lineTo
			}
			else
			{
				var i0:int = divisions;
				var i1:int, i2:int, n:int;
				var tmp0:Vector.<Curve>, tmp1:Vector.<Curve>;
				
				var curves:Vector.<Curve> = divideInCurves(); // On casse une première fois la courbe, pour en récupérer 2. 
				while( --i0 > -1 )
				{
					tmp0 = curves;
					
					i2 = 0;
					n = tmp0.length; 
					curves = new Vector.<Curve>( n << 1, true ); // Etant donné qu'on va récupérer deux courbes pour chaque courbe, on multiplie le nombre de courbes par 2.		
					for ( i1 = 0; i1 < n; ++i1 )
					{
						tmp1 = tmp0[ i1 ].divideInCurves();
						
						curves[ i2 ] = tmp1[ 0 ];
						++i2
						curves[ i2 ] = tmp1[ 1 ];
						++i2
					}					
				}				
				// Maintenant on prépare le Vector de Point.
				
				n = curves.length;
				points = new Vector.<Point>( n + 2, true );
				
				points[ 0 ] = curves[ 0 ].start;
				for ( i0 = 0; i0 < n; ++i0 )
					points[ i0 + 1 ] = curves[ i0 ].control;
				
				points[ i0 + 1 ] = curves[ i0 - 1 ].end;
			}
			
			return points;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/**
		 * Retourne la longueur correcte de la courbe.
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