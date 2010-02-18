
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.scenes.grid 
{
	import flash.display.Sprite;
	import fr.minuit4.games.tilebased.core.maps.Map;
	import fr.minuit4.games.tilebased.scenes.tiles.Tile;
	
	public class Grid extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _map:Map;
		private var _type:String;
		
		private var _tiles:Vector.<Vector.<Tile>>
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Grid( tileSize:int, map:Map, type:String ) 
		{
			this._tileSize = tileSize;
			this._map = map;
			this._type = type;
			
			build();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function build():void
		{
			destroy();
			
			var tile:Tile;
			
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
				for ( j = 0; j < _map.height; ++j )
				{
					// create tiles;
				}
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