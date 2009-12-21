
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.device.PlayPauseButton;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	public class PlayPauseButtonSkin extends PlayPauseButton
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PlayPauseButtonSkin() 
		{
			_visualManager = VisualManager.getInstance();
			
			this.playButton = new PlayButtonSkin();
			this.pauseButton = new PauseButtonSkin();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}