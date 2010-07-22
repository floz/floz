package com.isoo.map 
{
	import com.isoo.data.TileManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author David Ronai
	 */
	public class TileSprite extends Sprite
	{
		private var _id:int;
		
		public function TileSprite() 
		{
			cacheAsBitmap = true;
			drawSimpleTile();
		}
		
		public function drawSimpleTile():void
		{
			while( numChildren > 0)
				removeChildAt( 0 )
				
			var tileW:int = Tile.Width;
			var tileH:int = Tile.Height;
			
			graphics.clear();
			
			graphics.beginFill( 0xFFFFFF );	
				
			graphics.lineStyle(1, 0x666666);
			graphics.moveTo( tileW/2, 0);
			graphics.lineTo( tileW, tileH/2);
			graphics.lineTo( tileW/2, tileH);
			graphics.lineTo(0, tileH/2);
			graphics.lineTo( tileW / 2, 0);
			graphics.endFill( );
			
			graphics.beginFill( 0xFFFFFF );
			graphics.moveTo( 0, tileH / 2);
			graphics.lineTo(0, tileH / 2 +5);
			graphics.lineTo( tileW / 2, tileH + 5);
			graphics.lineTo( tileW, tileH / 2 + 5);
			graphics.lineTo( tileW, tileH / 2);
			graphics.lineTo( tileW/2, tileH);
			graphics.lineTo(0, tileH/2);
			graphics.endFill();
		}
		
		private function drawImage(bitmapData:BitmapData):void 
		{
			var bitmap:Bitmap
			
			if ( numChildren == 0 ){
				bitmap = new Bitmap();
				addChild( bitmap );
			} else {
				bitmap = getChildAt( 0 ) as Bitmap;
			}
			
			bitmap.bitmapData = bitmapData;
		}
		
		public function get id():int { return _id; }
		
		public function set id(value:int):void 
		{
			if ( _id != value ) {
				graphics.clear();
				if( value > 1 ){
					var bitmapData:BitmapData = TileManager.getImage(value);
					if ( bitmapData != null )
						drawImage( bitmapData )
					else {
						drawSimpleTile();
					}
				} else {
					drawSimpleTile();
				}
			}
			_id = value;
		}
		
	}

}