﻿
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
			
			var command:String;
			var datas:Array;
			
			graphics.lineStyle( 1, 0xff0000 );
			graphics.beginFill( 0x444444 );
			
			var n:int = _datas.length;
			for ( var i:int; i < n; ++i )
			{
				command = _datas[ i ][ 0 ];
				datas = _datas[ i ][ 1 ];
				
				if ( command == GlyphDatas.MOVE_TO )
				{
					graphics.moveTo( datas[ 0 ], datas[ 1 ] );
				}
				else if ( command == GlyphDatas.LINE_TO )
				{
					graphics.lineTo( datas[ 0 ], datas[ 1 ] );
					addMark( datas[ 0 ], datas[ 1 ] );
				}
				else if ( command == GlyphDatas.CURVE_TO )
				{
					//graphics.lineTo( datas[ 0 ], datas[ 1 ] );
					//graphics.lineTo( datas[ 2 ], datas[ 3 ] );
					graphics.curveTo( datas[ 0 ], datas[ 1 ], datas[ 2 ], datas[ 3 ] );
					addMark( datas[ 2 ], datas[ 3 ], false );
					addMark( datas[ 0 ], datas[ 1 ], true );
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