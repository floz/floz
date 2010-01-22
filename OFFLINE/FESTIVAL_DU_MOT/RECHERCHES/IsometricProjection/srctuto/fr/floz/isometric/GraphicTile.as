
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric 
{
	import flash.display.DisplayObject;
	
	public class GraphicTile extends IsoObject
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GraphicTile( size:Number, classRef:Class, xoffset:Number, yoffset:Number ) 
		{
			super( size );
			
			var gfx:DisplayObject = new classRef() as DisplayObject;
			gfx.x = -xoffset;
			gfx.y = -yoffset;
			addChild( gfx );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}