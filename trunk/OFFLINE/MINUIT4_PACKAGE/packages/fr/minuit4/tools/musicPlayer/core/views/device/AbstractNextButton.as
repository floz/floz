
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views.device
{
	import fr.minuit4.tools.musicPlayer.core.views.ButtonComponent;

	import flash.events.MouseEvent;

	/**
	 * The AbstractNextButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * This button will jumpt to the next track.
	 */
	public class AbstractNextButton extends ButtonComponent
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractNextButton() 
		{
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		/**
		 * Switch to next track.
		 */
		override protected function onClick(e:MouseEvent):void 
		{
			_musicManager.nextTrack();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}