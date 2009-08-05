
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	
	public class AbstractDisplay extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _visualManager:VisualManager;
		protected var _background:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractDisplay() 
		{
			_visualManager = VisualManager.getInstance();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function drawBackground():void
		{
			_background = new Shape();
			addChild( _background );
			
			// Abstract method, must be overidded
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}