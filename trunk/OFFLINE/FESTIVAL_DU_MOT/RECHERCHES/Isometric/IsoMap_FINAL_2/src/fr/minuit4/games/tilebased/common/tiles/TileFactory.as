
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.common.tiles 
{
	import fr.minuit4.games.tilebased.common.materials.Material;
	import fr.minuit4.games.tilebased.common.orientations.Orientation;
	import fr.minuit4.games.tilebased.isometric.tiles.TileIso;
	import fr.minuit4.games.tilebased.orthogonal.tiles.TileOrtho;
	
	public class TileFactory 
	{
		
		public static function create( material:Material, size:int, orientation:String = Orientation.ORTHOGONAL ):Tile
		{
			switch( orientation )
			{
				case Orientation.ORTHOGONAL: return new TileOrtho( material, size ); break;
				case Orientation.ISOMETRIC: return new TileIso( material, size ); break;
				default: return new TileOrtho( material, size ); break;
			}
		}
		
	}
	
}