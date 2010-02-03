
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.builders 
{
	import maps.types.RepresentationType;
	
	public class MapBuilderFactory 
	{
		
		public static function createBuilder( type:String ):IMapBuilder
		{
			switch( type )
			{
				case RepresentationType.NORMAL : return new Map2DBuilder(); break;
				case RepresentationType.ISOMETRIC : return new MapIsoBuilder(); break;
				default : return null;
			}
		}
		
	}
	
}