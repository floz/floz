package com.isoo.map 
{
	import flash.display.BitmapData;
	import com.isoo.objects.IsoBlock;

	import com.isoo.algo.astar.AStar;
	import com.isoo.algo.astar.IAStarSearchable;

	public class Map implements IAStarSearchable
	{
		private var _height:uint;
		private var _width:uint;
		private var map:Vector.<Vector.<Tile>>;
		private var _aStar:AStar;
		
		/**
		 * Create a map with only simple tile
		 * 
		 * @param	height height of the map
		 * @param	width width of the map
		 */
		public function Map( height:int, width:int ) 
		{
			
			_width = width;
			_height = height;
			
			map = new Vector.<Vector.<Tile>>(height);
			
			for ( var i:int = 0; i < height; i++) 
			{
				map[i] = new Vector.<Tile>(width);
				for ( var j:int = 0; j < width; j++) 
				{
					map[i][j] = new Tile();
				}
			}
			remakeAStar();
		}
		
		public function copy( map:Map ):void
		{
			for ( var i:int = 0; i < height; i++) 
			{
				for ( var j:int = 0; j < width; j++) 
				{
					if( i < map.height && j <map.width)
						this.map[i][j] = map.getTile(j,i);
				}
			}
			remakeAStar();
		}
		
		public function remakeAStar():void
		{
			_aStar = new AStar( this );
		}
		
		public function isWalkable(x:int, y:int):Boolean
		{
			if ( x > _width-1 || x < 0 || y > _height-1 || y < 0)
				return false;
			
			return map[y][x].walkable;
			remakeAStar();
		}
		
		public function isKillable(x:int, y:int):Boolean
		{
			if ( x > _width-1 || x < 0 || y > _height-1 || y < 0)
				return false;
			
			return map[y][x].killable;
		}
		
		public function getTile(x:int, y:int):Tile
		{
			if ( x > _width-1 || x < 0 || y > _height-1 || y < 0)
				return null;
			
			return map[y][x];
		}
		
		public function get height():uint { return _height; }
		public function get width():uint { return _width; }
		
		public function get aStar():AStar { return _aStar; }
		
	}
	
}