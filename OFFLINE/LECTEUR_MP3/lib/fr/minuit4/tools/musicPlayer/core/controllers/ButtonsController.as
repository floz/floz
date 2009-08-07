
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.controllers 
{
	import flash.events.MouseEvent;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	
	public class ButtonsController 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ButtonsController() 
		{
			_musicManager = MusicManager.getInstance();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		public function onPlayClick( e:MouseEvent ):void
		{
			_musicManager.play();
		}
		
		public function onPauseClick( e:MouseEvent ):void
		{
			_musicManager.pause();
		}
		
		public function onStopClick( e:MouseEvent ):void
		{
			_musicManager.stop();
		}
		
		public function onNextClick( e:MouseEvent ):void
		{
			_musicManager.nextTrack();
		}
		
		public function onPrevClick( e:MouseEvent ):void
		{
			_musicManager.prevTrack();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}