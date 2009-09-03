
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.tools.musicPlayer.core.AbstractMusicPlayer;
	import fr.minuit4.tools.musicPlayer.core.views.DeviceComponent;
	import fr.minuit4.tools.musicPlayer.core.views.PlaylistComponent;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	import fr.minuit4.tools.musicPlayer.views.Device;
	import fr.minuit4.tools.musicPlayer.views.Playlist;
	
	/**
	 * The minuit4 music player.
	 * You have to configure a device to interact with.
	 * The playlist is optionnal.
	 */
	public class MusicPlayer extends AbstractMusicPlayer
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MusicPlayer( device:DeviceComponent, playlist:PlaylistComponent = null ) 
		{
			super( device, playlist );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}