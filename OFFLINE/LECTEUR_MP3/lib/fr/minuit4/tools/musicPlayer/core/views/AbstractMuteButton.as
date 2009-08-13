
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views 
{
	import flash.events.MouseEvent;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	public class AbstractMuteButton extends ButtonComponent
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _mute:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractMuteButton() 
		{
			super();
			
			_musicManager.addEventListener( MusicEvent.VOLUME_CHANGED, onVolumeChanged );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onVolumeChanged(e:MusicEvent):void 
		{
			_mute = _musicManager.isMute();
			switchState();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function onClick(e:MouseEvent):void 
		{
			if ( _musicManager.isMute() )
				_musicManager.unmute();
			else 
				_musicManager.mute();
			
			_mute = _musicManager.isMute();
			switchState();
		}
		
		protected function switchState():void
		{
			// ABSTRACT METHOD - must be overrided.
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}