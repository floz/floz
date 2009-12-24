
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.typography 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import fr.floz.geom.CurveBezier;
	
	public class Glyph extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _glyphName:String;
		private var _datas:Array;
		
		private const _stepLine:int = 4;
		private const _stepCurves:int = 5;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Glyph( glyphName:String, datas:Array ) 
		{
			this._glyphName = glyphName;
			this._datas = datas;
			
			draw();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function draw():void
		{
			graphics.clear();
			
			var command:String;
			var datas:Array;
			
			//graphics.lineStyle( 1, 0xff0000 );
			graphics.beginFill( 0xffffff );
			
			var dx:Number, dy:Number, dist:Number, vx:Number, vy:Number, px:Number, py:Number;
			var j:int, m:int, divisions:int;
			var last:Point = new Point();
			
			var n:int = _datas.length;
			for ( var i:int; i < n; ++i )
			{
				command = _datas[ i ][ 0 ];
				datas = _datas[ i ][ 1 ];
				
				if ( command == GlyphDatas.MOVE_TO )
				{
					graphics.moveTo( datas[ 0 ], datas[ 1 ] );
					last.x = datas[ 0 ];
					last.y = datas[ 1 ];
				}
				else if ( command == GlyphDatas.LINE_TO )
				{
					dx = datas[ 0 ] - last.x;
					dy = datas[ 1 ] - last.y;
					dist = dy - dx;
					if ( dist < 0 ) dist *= -1;
					
					divisions = dist / _stepLine;
					
					vx = dx / divisions;
					vy = dy / divisions;
					
					for ( j = 0; j < divisions; ++j )
					{
						px = vx * j + last.x;
						py = vy * j + last.y;
						
						graphics.lineTo( px, py );
						//addMark( px, py );
					}					
					graphics.lineTo( datas[ 0 ], datas[ 1 ] );
					//addMark( datas[ 0 ], datas[ 1 ] );
					
					last.x = datas[ 0 ];
					last.y = datas[ 1 ];
				}
				else if ( command == GlyphDatas.CURVE_TO )
				{
					var curve:CurveBezier = new CurveBezier( last, new Point( datas[ 0 ], datas[ 1 ] ), new Point( datas[ 2 ], datas[ 3 ] ) );
					divisions = curve.length / _stepCurves;
					if ( divisions == 0 ) divisions = 1;
					
					var points:Vector.<Point> = curve.divideInPoints( divisions );
					m = points.length;
					for ( j = 0; j < m; ++j )
						graphics.lineTo( points[ j ].x, points[ j ].y );
					
					last.x = points[ int( j - 1 ) ].x;
					last.y = points[ int( j - 1 ) ].y;
				}
			}
			
			graphics.endFill();
		}
		
		private function addMark( x:Number, y:Number, curvePoint:Boolean = false ):void
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( curvePoint ? 0x00ff00 : 0xff00ff );
			g.drawCircle( 0, 0, 1 );
			g.endFill();
			
			s.x = x;
			s.y = y;
			
			addChild( s );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get glyphName():String { return _glyphName; }
		
		public function set glyphName(value:String):void 
		{
			_glyphName = value;
		}
		
	}
	
}