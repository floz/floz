
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes.tiles 
{
	import games.scenes.tiles.primitives.Tile2D;
	import games.scenes.tiles.primitives.TileIso;
	import games.scenes.types.RepresentationType;
	
	public class TileFactory 
	{
		
		public static function create( size:int, type:String ):Tile
		{
			switch( type )
			{
				case RepresentationType.NORMAL: return new Tile2D( size ); break;
				case RepresentationType.ISOMETRIC: return new TileIso( size ); break;
				default: return null; break;
			}
		}
		
	}
	
}