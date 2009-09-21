
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	/**
	 * The AbstractMuteButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * Your MuteButton will have to overidde the following methods :
	 * - setMuteState
	 * - setUnmuteState
	 */
	public class AbstractMuteButton extends ButtonComponent
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractMuteButton() 
		{
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		override protected function onRemovedFromStage(e:Event):void 
		{
			super.onRemovedFromStage( e );			
			_musicManager.removeEventListener( MusicEvent.VOLUME_CHANGED, onVolumeChanged );
		}
		
		override protected function onAddedToStage(e:Event):void 
		{
			super.onAddedToStage( e );			
			_musicManager.addEventListener( MusicEvent.VOLUME_CHANGED, onVolumeChanged, false, 0, true );
		}
		
		private function onVolumeChanged(e:MusicEvent):void 
		{
			switchState();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/**
		 * Handle the changes of the MouseEvent.CLICK event.
		 */
		override protected function onClick(e:MouseEvent):void 
		{
			if ( _musicManager.isMute() )
				_musicManager.unmute();
			else 
				_musicManager.mute();
			
			switchState();
		}
		
		/**
		 * Switch the template of the button.
		 */
		private function switchState():void
		{
			if ( _musicManager.isMute() )
				setMuteState();
			else
				setUnmuteState();
		}
		
		/**
		 * Set the template of the mute button.
		 * This method will be called when the mute state will be reached.
		 */
		protected function setMuteState():void
		{
			// ABSTRACT METHOD, MUST BE OVERRIDED.
		}
		
		/**
		 * Set the template of the unmute button.
		 * This method will be called when the unmute state will be reached.
		 */
		protected function setUnmuteState():void
		{
			// ABSTRACT METHOD, MUST BE OVERRIDED.
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function dispose():void 
		{
			_musicManager.removeEventListener( MusicEvent.VOLUME_CHANGED, onVolumeChanged );
			super.dispose();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}