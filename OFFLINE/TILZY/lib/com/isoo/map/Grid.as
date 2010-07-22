package com.isoo.map 
{
	import com.isoo.geom.Point3D;
	import com.isoo.utils.IsoUtils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import com.isoo.map.Map;
	import com.isoo.map.Tile;
	import com.isoo.objects.IsoBlock;
	import flash.geom.Point;
	
	/**
	 * Draw grid floor
	 * @author David Ronai
	 */
	public class Grid extends Sprite
	{
		private var tileSprite:Sprite;
		private var background:Shape;
		private var bitmap:Bitmap;
		/**
		 * Grid Object
		 */
		public function Grid() 
		{
			background = new Shape();
			tileSprite = new Sprite();
			mouseChildren = false;
			addChild( background );
			addChild( tileSprite );
		}
		
		/**
		 * Draw grid with map
		 * 
		 * @param	map
		 * @param	filled
		 * @param	fillColor
		 */
		public function draw( map:Map, optimize:Boolean = false ):void
		{
			drawCase(map, optimize);
		}
		
		private function drawCase(map:Map, optimize:Boolean = false):void
		{
			if ( optimize ) 
			{
				while ( tileSprite.numChildren > 0 ) 
				{
					tileSprite.removeChildAt(0);
				}
				
				drawBackgound( map );
				//hideTile();
				
				var bitmapData:BitmapData = new BitmapData(background.width, background.height+10, true, 0x00FFFFFF);
				if ( bitmap == null )
				{
					bitmap = new Bitmap();
					addChild( bitmap );
				}
				
				bitmap.bitmapData = bitmapData;
				bitmap.x = -bitmap.width / 2;
				trace("BITMAP WIDTH : ", bitmap.width);
				var matrix:Matrix = new Matrix();
				var tile:TileSprite = new TileSprite();
				
				for ( var i:int = 0; i <  map.height; i++) 
				{
					for ( var j:int = 0; j < map.width; j++) 
					{
						var p:Point = IsoUtils.isoToScreen(j, i);
						tile.id = map.getTile(j, i).id;
						
						matrix.tx = p.x - Tile.Width/2 + bitmap.width / 2;
						matrix.ty = p.y;
						
						if ( map.getTile(j, i).visible ) 
							bitmapData.draw( tile, matrix )
					}
				}
			} 
			
			else 
			{
				while ( tileSprite.numChildren > map.width * map.height ) 
				{
					tileSprite.removeChildAt(tileSprite.numChildren - 1);
				}				
				while ( tileSprite.numChildren < map.width * map.height ) 
				{
					tileSprite.addChild(new TileSprite());
				}
				for (  i = 0; i <  map.height; i++) 
				{
					for ( j = 0; j < map.width; j++) 
					{
						p = IsoUtils.isoToScreen(j, i);
						tile = tileSprite.getChildAt(i * map.width + j) as TileSprite;
						tile.x = p.x - Tile.Width/2;
						tile.y = p.y;
						tile.id = map.getTile(j,i).id;
						if ( map.getTile(j, i).visible ) 
						{
							tile.visible = true;
						}
						else {
							tile.visible = false;
						}
					}
				}
			}
		}
		
		public function drawBackgound( map:Map ):void
		{
			background.graphics.clear();
			
			var tileW:int = Tile.Width;
			var tileH:int = Tile.Height;
			
			background.graphics.beginFill( 0, 0);
			
			var p:Point = IsoUtils.isoToScreen( 0, 0);
			background.graphics.moveTo(p.x, p.y);
			drawPoint( p, map );
			drawPoint( IsoUtils.isoToScreen( map.width,0),map );
			drawPoint( IsoUtils.isoToScreen( map.width,map.height),map );
			drawPoint( IsoUtils.isoToScreen( 0, map.height ),map );
			
			background.graphics.endFill( );
		}
		
		public function hideTile():void
		{
			tileSprite.visible = false;
			background.alpha = 0;
		}
		
		private function drawPoint(p:Point,map:Map):void
		{
			//background.graphics.drawCircle( p.x + map.height*Tile.Width*.5, p.y, 5); 
			background.graphics.lineTo(p.x, p.y);
		}
		
		public function activeShadow():void
		{
			background.filters = [new DropShadowFilter(35, 90,0,.3,25,25,1,1)];
		}
		
		public function dispose():void 
		{
			if ( bitmap != null ) {
				bitmap.bitmapData.dispose();
				removeChild( bitmap );
				bitmap = null;
			}
			if ( background != null ) {
				removeChild( background );
				background.filters = [];
				background.graphics.clear();
				background = null;
			}
			if ( tileSprite != null ) {
				removeChild(tileSprite );
				tileSprite = null;
			}
		}
		
	}

}