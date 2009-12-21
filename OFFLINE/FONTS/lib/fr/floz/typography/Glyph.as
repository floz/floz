
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
	
	public class Glyph extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _glyphName:String;
		private var _datas:Array;
		
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
			
			var l:int, n:int = _datas.length;
			var commands:Vector.<int> = new Vector.<int>( n, true );
			var datas:Vector.<Number> = new Vector.<Number>();
			
			graphics.lineStyle( 1, 0xff0000 );
			graphics.beginFill( 0x000000 );
			for ( var i:int; i < n; ++i )
			{
				switch( _datas[ i ][ 0 ] )
				{
					case GlyphDatas.MOVE_TO:
						commands[ i ] = GraphicsPathCommand.MOVE_TO;
						datas[ l ] = _datas[ i ][ 1 ][ 0 ];
						++l;
						datas[ l ] = _datas[ i ][ 1 ][ 1 ];
						++l;
						
						addMark( _datas[ i ][ 1 ][ 0 ], _datas[ i ][ 1 ][ 1 ] );
						
						break;
					case GlyphDatas.LINE_TO:
						commands[ i ] = GraphicsPathCommand.LINE_TO;
						datas[ l ] = _datas[ i ][ 1 ][ 0 ];
						++l;
						datas[ l ] = _datas[ i ][ 1 ][ 1 ];
						++l;
						
						addMark( _datas[ i ][ 1 ][ 0 ], _datas[ i ][ 1 ][ 1 ] );
						
						break;
					case GlyphDatas.CURVE_TO:
						commands[ i ] = GraphicsPathCommand.CURVE_TO;
						//commands[ i ] = GraphicsPathCommand.LINE_TO;
						datas[ l ] = _datas[ i ][ 1 ][ 0 ];
						++l;
						datas[ l ] = _datas[ i ][ 1 ][ 1 ];
						++l;
						datas[ l ] = _datas[ i ][ 1 ][ 2 ];
						++l;
						datas[ l ] = _datas[ i ][ 1 ][ 3 ];
						++l;
						break;
				}
			}
			graphics.drawPath( commands, datas );
			graphics.endFill();
		}
		
		private function addMark( x:Number, y:Number ):void
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0xff00ff );
			g.drawCircle( 0, 0, 2 );
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