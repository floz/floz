
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.tools.musicPlayer.manager.MusicManager;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	import fr.minuit4.tools.musicPlayer.views.Device;
	import fr.minuit4.tools.musicPlayer.views.Playlist;
	
	public class MusicPlayer extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _autoBuild:Boolean;		
		private var _visualManager:VisualManager;
		private var _musicManager:MusicManager;
		
		private var _device:Device;
		private var _playlist:Playlist;
		
		private var _configInfos:XML;
		private var _playlistInfos:XML;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MusicPlayer( autoBuild:Boolean = true ) 
		{
			this._autoBuild = autoBuild;
			
			init();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_visualManager = VisualManager.getInstance();
			_musicManager = MusicManager.getInstance();
			
			if ( _autoBuild ) build();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function build():void
		{
			_device = new Device();
			_device.build();
			addChild( _device );
			
			_playlist = new Playlist();
			_playlist.build();
			_playlist.y = _device.height - 1;
			addChild( _playlist );
		}
		
		public function setConfig( configInfos:XML ):void
		{
			this._configInfos = configInfos;
		}
		
		public function setPlaylist( playlistInfos:XML ):void
		{
			this._playlistInfos = playlistInfos;
		}
		
		public function addTrack( url:String ):void { _musicManager.addTrack( url ); }
		public function addTracks( urls:Array ):void { _musicManager.addTracks( urls ); }
		
		public function showPlaylist():void
		{
			
		}
		
		public function hidePlaylist():void
		{
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}