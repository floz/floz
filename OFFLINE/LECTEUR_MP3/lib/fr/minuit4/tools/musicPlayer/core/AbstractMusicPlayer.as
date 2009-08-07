
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core 
{
	import flash.display.Sprite;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	import fr.minuit4.tools.musicPlayer.core.views.DeviceComponent;
	import fr.minuit4.tools.musicPlayer.core.views.PlaylistComponent;
	
	public class AbstractMusicPlayer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _musicManager:MusicManager;
		
		protected var _device:DeviceComponent;
		protected var _playlist:PlaylistComponent;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractMusicPlayer( device:DeviceComponent, playlist:PlaylistComponent = null ) 
		{
			_device = device;
			_playlist = playlist;			
			
			_musicManager = MusicManager.getInstance();
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function init():void
		{
			addChild( _device );
			if( _playlist ) addChild( _playlist );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addTrack( url:String ):void { _musicManager.addTrack( url ); }
		public function addTracks( urls:Array ):void { _musicManager.addTracks( urls ); }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}