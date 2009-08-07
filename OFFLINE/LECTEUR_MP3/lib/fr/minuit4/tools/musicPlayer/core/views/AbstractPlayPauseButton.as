
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	
	public class AbstractPlayPauseButton extends ButtonComponent
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractPlayPauseButton() 
		{
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		override protected function onClick(e:MouseEvent):void 
		{
			if ( _musicManager.isPlaying() )
				_musicManager.pause();
			else
				_musicManager.play();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}