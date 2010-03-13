﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer 
{
	import fr.minuit4.tools.musicPlayer.core.AMusicPlayer;
	import fr.minuit4.tools.musicPlayer.core.views.DeviceComponent;
	import fr.minuit4.tools.musicPlayer.core.views.PlaylistComponent;

	/**
	 * The minuit4 music player.
	 * You have to configure a device to interact with.
	 * The playlist is optionnal.
	 */
	public class MusicPlayer extends AMusicPlayer
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MusicPlayer( device:DeviceComponent = null, playlist:PlaylistComponent = null ) 
		{
			super( device, playlist );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}