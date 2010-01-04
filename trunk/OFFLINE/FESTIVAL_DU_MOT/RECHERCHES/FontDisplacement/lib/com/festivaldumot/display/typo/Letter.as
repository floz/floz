
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.festivaldumot.display.typo
{
	import com.festivaldumot.geom.Curve;
	import flash.geom.Point;
	import net.badimon.five3D.typography.Typography3D;
	
	public class Letter 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const STEP_LINETO:int = 4;
		private static const STEP_CURVETO:int = 5;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _letter:String;
		private var _datas:Array;
		
		private var _path:Vector.<Point>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Letter( letter:String, typography:Typography3D ) 
		{
			this._letter = letter;
			
			_datas = typography.getMotif( _letter );			
			parse();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function parse():void
		{
			var command:String;
			var partDatas:Array;
			var last:Point = new Point();
			var points:Vector.<Point>;
			
			var dx:Number, dy:Number, dist:Number, vx:Number, vy:Number, px:Number, py:Number;
			var j:int, m:int, idx:int, divisions:int;
			
			_path = new Vector.<Point>();
			
			var n:int = _datas.length;
			for ( var i:int; i < n; ++i )
			{
				command = _datas[ i ][ 0 ];
				partDatas = _datas[ i ][ 1 ];
				
				if ( command == TypoDatas.MOVE_TO )
				{
					_path[ idx ] = new Point( partDatas[ 0 ], partDatas[ 1 ] );
					++idx;
					
					last.x = partDatas[ 0 ];
					last.y = partDatas[ 1 ];
				}
				else if ( command == TypoDatas.LINE_TO )
				{
					dx = partDatas[ 0 ] - last.x;
					dy = partDatas[ 1 ] - last.y;
					dist = Math.sqrt( dx * dx + dy * dy );
					
					divisions = dist / STEP_LINETO;
					
					vx = dx / divisions;
					vy = dy / divisions;
					
					j = divisions + 1;
					
					var cumulX:Number = 0;
					var cumulY:Number = 0;
					while ( --j > -1 )
					{
						px = cumulX + last.x;
						py = cumulY + last.y;
						
						_path[ idx ] = new Point( px, py );
						
						cumulX += vx;
						cumulY += vy;
						
						++idx;
					}
					
					last.x = px;
					last.y = py;
				}
				else if ( command == TypoDatas.CURVE_TO )
				{
					var curve:Curve = new Curve( last, new Point( partDatas[ 0 ], partDatas[ 1 ] ), new Point( partDatas[ 2 ], partDatas[ 3 ] ) );
					
					divisions = curve.length / STEP_CURVETO;
					if ( divisions == 0 ) divisions = 1;
					
					points = curve.divide( divisions ); // TODO: changer la valeur si la qualité ne convient pas. 2
					m = points.length;
					for ( j = 0; j < m; ++j )
					{
						_path[ idx ] = new Point( points[ j ].x, points[ j ].y );
						++idx;
					}
					
					last.x = points[ j - 1 ].x;
					last.y = points[ j - 1 ].y;
				}
				else
				{
					trace( "Glyph.parse --> command '" + command + "' non prise en compte" );
				}
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Renvoie tous les points permettant le tracé de la forme.
		 * @return	Vector.<Point>	Les points en question.
		 */
		public function getPath():Vector.<Point> { return _path; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}