
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
	import maps.Tile;
	
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
					tile = new Tile();
					map.addChild( tile );
					a.push( tile );
					
					g = tile.graphics;
					g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
					g.beginFill( mapDatas[ i ][ j ] ? 0x444444 : 0xeeeeee );
					g.drawRect( 0, 0, map.tileSize, map.tileSize );
					g.endFill();
					
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