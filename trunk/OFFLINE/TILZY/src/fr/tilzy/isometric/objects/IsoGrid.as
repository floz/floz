
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.isometric.objects 
{
	import fr.tilzy.common.materials.WireColorMaterial;
	import fr.tilzy.common.objects.GameObject;
	import fr.tilzy.common.objects.Grid;
	import fr.tilzy.core.maps.Map;
	import fr.tilzy.isometric.objects.primitives.IsoPlane;
	
	public class IsoGrid extends Grid
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoGrid( tileSize:int, map:Map ) 
		{
			super( tileSize, map );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function createTile( walkable:Boolean, tileSize:int ):GameObject 
		{
			var material:WireColorMaterial = walkable ? new WireColorMaterial( 0xeeeeee, .1, 0x000000, .1, 1 ) : new WireColorMaterial( 0x000000, .4, 0x000000, .3, 1 );
			return new IsoPlane( material, tileSize );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}