
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views.device
{
	import fr.minuit4.tools.musicPlayer.core.events.MusicEvent;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * The AbstractPlayPauseButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * It will permite you to create a custom Play/Pause button for
	 * a music player.
	 * 
	 * Your Play/Pause button will have to overidde those following methods :
	 * - setPlayState
	 * - setPauseState
	 */
	public class PlayPauseButton extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		
		private var _playButton:PlayButton;
		private var _pauseButton:PauseButton;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PlayPauseButton() 
		{
			_musicManager = MusicManager.getInstance();
			addEventListener( Event.ADDED_TO_STAGE , onAddedToStage, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_musicManager.removeEventListener( MusicEvent.PLAY, onStatusChange );
			_musicManager.removeEventListener( MusicEvent.PAUSE, onStatusChange );
			_musicManager.removeEventListener( MusicEvent.STOP, onStatusChange );
			
			addEventListener( Event.ADDED_TO_STAGE , onAddedToStage, false, 0, true );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true );
			
			_musicManager.addEventListener( MusicEvent.PLAY, onStatusChange, false, 0, true );
			_musicManager.addEventListener( MusicEvent.PAUSE, onStatusChange, false, 0, true );
			_musicManager.addEventListener( MusicEvent.STOP, onStatusChange, false, 0, true );
			switchState();
		}
		
		private function onStatusChange( e:MusicEvent ):void
		{
			switchState();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function switchState():void
		{
			if( _musicManager.isPlaying() )
				setPauseState();
			else
				setPlayState();
		}
		
		/**
		 * Set the template of the play button.
		 * This method will be called when the play state will be reached.
		 */
		protected function setPlayState():void
		{
			if( !_playButton ) return;
			
			while ( numChildren ) removeChildAt( 0 );
			addChild( _playButton );
		}
		
		/**
		 * Set the template of the pause button.
		 * This method will be called when the pause state will be reached.
		 */
		protected function setPauseState():void
		{
			if( !_pauseButton ) return;
			
			while ( numChildren ) removeChildAt( 0 );
			addChild( _pauseButton );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void 
		{
			_pauseButton.dispose();
			_playButton.dispose();
			
			_musicManager.removeEventListener( MusicEvent.PLAY, switchState );
			_musicManager.removeEventListener( MusicEvent.PAUSE, switchState );
			_musicManager.removeEventListener( MusicEvent.STOP, switchState );			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set playButton( value:PlayButton ):void
		{
			if( _playButton )
			{
				_playButton.dispose();
				if( _playButton.parent ) removeChild( _playButton );
			}
			
			_playButton = value;
			addChild( _playButton );
			
			switchState();
		}
		public function get playButton():PlayButton { return this._playButton; }
		
		public function set pauseButton( value:PauseButton ):void
		{
			if( _pauseButton )
			{
				_pauseButton.dispose();
				if( _pauseButton.parent ) removeChild( _pauseButton );
			}
			
			_pauseButton = value;
			addChild( _pauseButton );
			
			switchState();
		}
		public function get pauseButton():PauseButton { return this._pauseButton; }
		
	}
}