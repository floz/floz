
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
	 * The AbstractMuteButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * Your MuteButton will have to overidde the following methods :
	 * - setMuteState
	 * - setUnmuteState
	 */
	public class AMuteUnmuteButton extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		
		private var _muteButton:AMuteButton;
		private var _unmuteButton:AUnmuteButton;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AMuteUnmuteButton() 
		{
			_musicManager = MusicManager.getInstance();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}

		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );	
						
			_musicManager.removeEventListener( MusicEvent.VOLUME_CHANGED, onVolumeChanged );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );	
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true );	
				
			_musicManager.addEventListener( MusicEvent.VOLUME_CHANGED, onVolumeChanged, false, 0, true );
		}
		
		private function onVolumeChanged(e:MusicEvent):void 
		{
			switchState();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/**
		 * Switch the template of the button.
		 */
		private function switchState():void
		{
			if ( _musicManager.isMute() )
				setUnmuteState();
			else
				setMuteState();
		}
		
		/**
		 * Set the template of the mute button.
		 * This method will be called when the mute state will be reached.
		 */
		protected function setMuteState():void
		{
			if( !_muteButton ) return;
			
			while ( numChildren ) removeChildAt( 0 );
			addChild( _muteButton );
		}
		
		/**
		 * Set the template of the unmute button.
		 * This method will be called when the unmute state will be reached.
		 */
		protected function setUnmuteState():void
		{
			if( !_unmuteButton ) return;
			
			while ( numChildren ) removeChildAt( 0 );
			addChild( _unmuteButton );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void 
		{
			_musicManager.removeEventListener( MusicEvent.VOLUME_CHANGED, onVolumeChanged );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set unmuteButton( value:AUnmuteButton ):void
		{
			if( _unmuteButton )
			{
				_unmuteButton.dispose();
				if( _unmuteButton.parent ) removeChild( _unmuteButton );
			}
			_unmuteButton = value;
			addChild( _unmuteButton );
			
			switchState();
		}
		public function get unmuteButton():AUnmuteButton { return _unmuteButton; }
		
		public function set muteButton( value:AMuteButton ):void
		{
			if( _muteButton )
			{
				_muteButton.dispose();
				if( _muteButton.parent ) removeChild( _muteButton );
			}
			_muteButton = value;
			addChild( _muteButton );
			
			switchState();
		}
		public function get muteButton():AMuteButton { return _muteButton; }
		
	}
	
}