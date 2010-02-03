
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.builders 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import maps.IMap;
	import maps.tiles.ITile;
	import maps.tiles.Tile;
	import maps.tiles.TileFactory;
	
	public class Map2DBuilder extends MapBuilder
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Map2DBuilder() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function build( map:IMap ):void 
		{
			super.build( map );
			
			var tile:Tile;
			var g:Graphics;
			var mapDatas:/*Array*/Array = map.mapDatas;
			var a:Array;
			
			var px:Number = 0;
			var py:Number = 0;
			
			var n:int = mapDatas.length;
			var j:int, m:int;
			for ( var i:int; i < n; ++i )
			{
				a = [];
				
				px = 0;
				m = mapDatas[ i ].length;
				for ( j = 0; j < m; ++j )
				{
					tile = Tile( TileFactory.createTile( _map.tileSize, _map.type ) );
					tile.walkable = mapDatas[ i ][ j ] ? true : false;
					map.addChild( tile );
					a.push( tile );
					
					tile.x = px;
					tile.y = py;
					px += map.tileSize;					
				}
				py += map.tileSize;
				
				_tiles.push( a );
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}