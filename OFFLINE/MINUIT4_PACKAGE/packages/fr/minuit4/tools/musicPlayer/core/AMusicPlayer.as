
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
	
	public class AMusicPlayer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _musicManager:MusicManager;
		
		protected var _device:DeviceComponent;
		protected var _playlist:PlaylistComponent;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AMusicPlayer( device:DeviceComponent = null, playlist:PlaylistComponent = null ) 
		{
			_device = device;
			_playlist = playlist;			
			
			_musicManager = MusicManager.getInstance();
			
			if( _device ) addChild( _device );
			if( _playlist ) addChild( _playlist );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addSong( song:Object ):void { _musicManager.addSong( song ); }
		public function addSongs( songs:Array ):void { _musicManager.addSongs( songs ); }
		public function getSongsCount():int { return _musicManager.getSongs().length; }
		public function dispose():void { _musicManager.dispose(); }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set device( device:DeviceComponent ):void
		{
			if( _device )
				removeChild( _device );
			
			_device = device;
			addChild( _device );
		}
		public function get device():DeviceComponent { return _device; }
		
		public function set playlist( playlist:PlaylistComponent ):void
		{
			if( _playlist )
				removeChild( _playlist );
			
			_playlist = playlist;
			addChild( _playlist );
		}
		
	}
	
}