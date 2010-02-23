
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.common.scenes.grid 
{
	import fr.minuit4.games.tilebased.common.materials.Material;
	import fr.minuit4.games.tilebased.common.orientations.Orientation;
	
	public class GridItemFactory 
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