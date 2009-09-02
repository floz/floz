
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
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	/**
	 * The AbstractPlayPauseButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * It will permite you to create a custom Play/Pause button for
	 * a music player.
	 */
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
		
		override protected function onRemovedFromStage(e:Event):void 
		{
			super.onRemovedFromStage(e);
			
			_musicManager.removeEventListener( MusicEvent.PLAY, switchState );
			_musicManager.removeEventListener( MusicEvent.PAUSE, switchState );
			_musicManager.removeEventListener( MusicEvent.STOP, switchState );
		}
		
		override protected function onAddedToStage(e:Event):void 
		{
			super.onAddedToStage(e);
			
			_musicManager.addEventListener( MusicEvent.PLAY, switchState, false, 0, true );
			_musicManager.addEventListener( MusicEvent.PAUSE, switchState, false, 0, true );
			_musicManager.addEventListener( MusicEvent.STOP, switchState, false, 0, true );
			switchState( null );
		}
		
		override protected function onClick(e:MouseEvent):void 
		{
			if ( _musicManager.isPlaying() )
				_musicManager.pause();
			else
				_musicManager.play();
		}
		
		private function switchState( e:MusicEvent ):void
		{
			if( _musicManager.isPlaying() )
				setPauseState();
			else
				setPlayState();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/**
		 * Set the template of the play button.
		 * This method will be called when the play state will be reached.
		 */
		protected function setPlayState():void
		{
			// ABSTRACT METHOD, MUST BE OVERRIDED.
		}
		
		/**
		 * Set the template of the pause button.
		 * This method will be called when the pause state will be reached.
		 */
		protected function setPauseState():void
		{
			// ABSTRACT METHOD, MUST BE OVERRIDED.
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}