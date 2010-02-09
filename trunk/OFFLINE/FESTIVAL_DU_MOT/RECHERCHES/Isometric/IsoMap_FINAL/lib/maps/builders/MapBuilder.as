
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.builders 
{
	import flash.display.Graphics;
	import maps.IMap;
	import maps.tiles.Tile;
	import maps.tiles.TileFactory;
	
	public class MapBuilder implements IMapBuilder
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _map:IMap;
		protected var _tiles:/*Array*/Array;
		//protected var _nodes:/*Array*/Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MapBuilder() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function build( map:IMap ):void
		{
			this._map = map;
			_tiles = [];
			//_nodes = [];
			
			var tile:Tile;
			var g:Graphics;
			var mapDatas:/*Array*/Array = map.mapDatas;
			var a1:Array;// a2:Array;
			
			var px:Number = 0;
			var py:Number = 0;
			
			var n:int = mapDatas.length;
			var j:int, m:int;
			for ( var i:int; i < n; ++i )
			{
				a1 = [];
				//a2 = [];
				
				px = 0;
				m = mapDatas[ i ].length;
				for ( j = 0; j < m; ++j )
				{
					tile = Tile( TileFactory.createTile( _map.tileSize, _map.type ) );
					tile.walkable = mapDatas[ i ][ j ] ? true : false;
					map.addChild( tile );
					
					//tile.node.x = j;
					//tile.node.y = i;
					
					a1.push( tile );
					//a2.push( tile.node );
					
					tile.x = px;
					tile.y = py;
					px += map.tileSize;					
				}
				py += map.tileSize;
				
				_tiles.push( a1 );
				//_nodes.push( a2 );
			}
		}
		
		public function getTile( x:int, y:int ):Tile
		{
			if ( y < 0 || y > _map.mapDatas.length - 1 ) return null;
			if ( x < 0 || x > _map.mapDatas[ 0 ].length - 1 ) return null;
			
			return _tiles[ y ][ x ];
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tiles():/*Array*/Array { return _tiles; }
		
		//public function get nodes():/*Array*/Array { return _nodes; }
		
	}
	
}