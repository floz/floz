
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.scenes.grid 
{
	import flash.display.Sprite;
	import fr.minuit4.games.tilebased.core.maps.Map;
	import fr.minuit4.games.tilebased.materials.Material;
	import fr.minuit4.games.tilebased.materials.WireColorMaterial;
	import fr.minuit4.games.tilebased.scenes.tiles.Tile;
	import fr.minuit4.games.tilebased.scenes.tiles.TileFactory;
	
	public class Grid extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _map:Map;
		private var _orientation:String;
		
		private var _tiles:Vector.<Vector.<Tile>>
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Grid( tileSize:int, map:Map, orientation:String ) 
		{
			this._tileSize = tileSize;
			this._map = map;
			this._orientation = orientation;
			
			build();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function build():void
		{
			destroy();
			
			var tile:Tile;
			var material:Material;
			
			var px:Number = 0;
			var py:Number = 0;
			
			var v:Vector.<Tile>;
			
			var i:int;
			var j:int;
			for ( i = 0; i < _map.height; ++i )
			{
				v = new Vector.<Tile>( _map.width, true );
				_tiles[ i ] = v;
				
				px = 0;
				for ( j = 0; j < _map.width; ++j )
				{
					material = _map.isWalkable( j, i ) ? new WireColorMaterial( 0x444444, 1, 0x444444, 1, 1 ) : new WireColorMaterial( 0x444444, 1, 0x444444, 1, 1 );
					tile = TileFactory.create( material, _tileSize, _orientation );
					tile.x = px;
					tile.y = py;
					tile.cacheAsBitmap = true;
					addChild( tile );
					
					v[ j ] = tile;
					
					px += _tileSize;
				}
				py += _tileSize;
			}
		}
		
		private function destroy():void
		{
			while ( numChildren ) removeChildAt( 0 );
			_tiles = new Vector.<Vector.<Tile>>();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function refresh():void
		{
			build();
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