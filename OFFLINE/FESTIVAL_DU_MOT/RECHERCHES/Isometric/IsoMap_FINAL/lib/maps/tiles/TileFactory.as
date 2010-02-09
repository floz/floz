
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.tiles 
{
	import maps.types.RepresentationType;
	
	public class TileFactory 
	{
		
		public static function createTile( size:int, type:String ):Tile
		{
			switch( type )
			{
				case RepresentationType.NORMAL : return new NormalTile( size ); break;
				case RepresentationType.ISOMETRIC : return new IsoTile( size ); break;
				default : return null;
			}
		}
		
	}
	
}