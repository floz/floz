﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import flash.events.Event;
	import flash.text.TextField;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	public class MusicTitle extends TextField
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MusicTitle() 
		{
			_musicManager = MusicManager.getInstance();			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onID3(e:Event):void 
		{
			this.text = _musicManager.getCurrentArtist() + " - " + _musicManager.getCurrentSong();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_musicManager.addEventListener( Event.ID3, onID3 );			
			this.text = "... - ...";
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}