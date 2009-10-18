
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ui.panel.header 
{
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
			var r:uint = color >> 16;
			var g:uint = ( color >> 8 ) & 0xff;
			var b:uint = color & 0xff;
			var colorTransform:ColorTransform = new ColorTransform( 1, 1, 1, 1, r, g, b );
			display.transform.colorTransform = colorTransform;
			
			addChild( display );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}