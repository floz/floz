
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ui.panel.header 
{
	import elive.utils.EliveUtils;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class Cloud extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Cloud( display:DisplayObject = null, color:uint = 0xffffff ) 
		{
			if ( display ) setDisplay( display, color );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setDisplay( display:DisplayObject, color:uint ):void
		{
			display.transform.colorTransform = EliveUtils.getColorTransform( color );			
			addChild( display );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}