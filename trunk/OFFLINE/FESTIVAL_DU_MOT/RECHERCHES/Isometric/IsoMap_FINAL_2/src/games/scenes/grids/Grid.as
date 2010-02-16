
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes.grids 
{
	import flash.display.Sprite;
	import games.scenes.maps.Map;
	import games.scenes.tiles.Tile;
	import games.scenes.tiles.TileFactory;
	
	public class Grid extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _map:Map;
		private var _type:String;
		
		private var _tiles:Vector.<Vector.<Tile>>;
		
		private var _width:int;
		private var _height:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Grid( tileSize:int, map:Map, type:String ) 
		{
			this._tileSize = tileSize;
			this._map = map;
			this._type = type;
			
			_width = _map.width;
			_height = _map.height;
			
			build();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function build():void
		{
			destroy();
			
			var tile:Tile;
			
			var px:Number = 0;
			var py:Number = 0;
			
			var v:Vector.<Tile>;
			
			var i:int, j:int;
			for ( i = 0; i < _height; ++i ) // y
			{
				v = new Vector.<Tile>( _width, true );
				_tiles[ i ] = v;
				
				px = 0;
				for ( j = 0; j < _width; ++j ) // x
				{
					tile = TileFactory.create( _tileSize, _type );
					tile.x = px;
					tile.y = py;
					tile.color = _map.datas[ i ][ j ] == 0 ? 0xffffff : 0x222222;
					addChild( tile );
					
					v[ j ] = tile;
					
					px += _tileSize;
				}
				py += _tileSize;
			}
		}
		
		protected function destroy():void
		{
			while ( numChildren ) removeChildAt( 0 );
			_tiles = new Vector.<Vector.<Tile>>();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getTile( x:int, y:int ):Tile
		{
			if ( !_map.isInside( x, y ) ) return null;
			return _tiles[ y ][ x ];
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize(value:int):void 
		{
			_tileSize = value;
			build();
		}
		
	}
	
}