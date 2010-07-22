/**
 * Written by :
 * @author David Ronai
 */
package com.isoo.objects 
{
	import flash.display.Sprite;
	import com.isoo.map.Tile;
	
	public class IsoBlock extends IsoObject
	{
		
		private var _color:uint;
		
		private var _depth:int;
		private var _height:int;
		private var _lineColor:int;
		
		/**
		 * 
		 * @param	height
		 * @param	pronfondeur
		 * @param	color
		 * @param	lineColor
		 */
		public function IsoBlock( height:int, depth:int=32, color:uint = 0xFFFFFF, lineColor:int = 0x666666 ) 
		{
			_height = height;
			_depth = depth;			
			_color = color;
			_lineColor = lineColor;
			
			draw();
		}
		
		override public function get x():Number { return super.x+Tile.Width * .5; }
		override public function set x(value:Number):void 
		{
			super.x = value-Tile.Width*.5 ;
		}
		
		override public function get y():Number { return super.y-Tile.Height * .5; }
		
		override public function set y(value:Number):void 
		{
			super.y = value+Tile.Height * .5;
		}
		
		public function draw():void 
		{
			graphics.clear();
			
			var red:int = _color >> 16;
			var green:int = _color >> 8 & 0xFF;
			var blue:int = _color & 0xFF;
			
			var leftShadow:uint = (red * .9 ) << 16 |
			                      (green * .9) << 8 |
								  (blue * .9);
			
			var rightShadow:uint = (red * .75 ) << 16 |
			                       (green * .75) << 8 |
								   (blue * .75); 
			
			graphics.lineStyle(1, _lineColor);
			
			//Haut
			graphics.beginFill( _color );
			graphics.moveTo( Tile.Width / 2, -_height );
			graphics.lineTo( Tile.Width / 2+_depth, -_height -_depth*.5 );
			graphics.lineTo( Tile.Width+_depth, Tile.Height / 2 -_height -_depth*.5);
			graphics.lineTo( Tile.Width, Tile.Height / 2 -_height);
			graphics.lineTo( Tile.Width / 2, -_height);
			graphics.endFill();
			
			//Face
			graphics.beginFill( leftShadow );
			graphics.moveTo( Tile.Width / 2, 0);
			graphics.lineTo( Tile.Width / 2, -_height );
			graphics.lineTo( Tile.Width, Tile.Height / 2 -_height);
			graphics.lineTo( Tile.Width, Tile.Height / 2);
			graphics.lineTo( Tile.Width / 2, 0);
			graphics.endFill();
			
			//Cote
			graphics.beginFill( rightShadow );
			graphics.moveTo( Tile.Width + _depth, Tile.Height / 2 -_height -_depth * .5 );
			graphics.lineTo( Tile.Width + _depth, Tile.Height / 2 -_depth * .5);
			graphics.lineTo( Tile.Width , Tile.Height / 2 );
			graphics.lineTo( Tile.Width, Tile.Height / 2 -_height );
			graphics.lineTo( Tile.Width+_depth, Tile.Height / 2 -_height -_depth*.5);
		}
		
	}
	
}