
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	public class MusicManager extends EventDispatcher
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const AUTOPLAY:Boolean = false;
		
		private const _playEvent:MusicEvent = new MusicEvent( MusicEvent.PLAY );
		private const _stopEvent:MusicEvent = new MusicEvent( MusicEvent.STOP );
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:MusicManager;
		
		private var _tracks:Array;
		private var _currentTrack:SoundChannel;
		private var _soundManager:Sound;
		private var _request:URLRequest;
		private var _currentTrackIndex:int;
		private var _bufferPosition:Number = 0;
		
		private var _playing:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MusicManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use getInstance() methode instead." );			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onSoundComplete(e:Event):void 
		{
			_playing = false;
			_currentTrack = null;
			nextTrack();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_tracks = [];			
			_soundManager = new Sound();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():MusicManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new MusicManager();
				} _allowInstanciation = false;
			}
			
			return _instance;
		}
		
		public function nextTrack():void
		{
			_currentTrackIndex = _currentTrackIndex + 1 >= tracksCount ? 0 : _currentTrackIndex + 1;
			play();
		}
		
		public function prevTrack():void
		{
			_currentTrackIndex = _currentTrackIndex - 1 >= 0 ? _currentTrackIndex - 1 : 0;
			play();
		}
		
		public function addTrack( url:String ):void
		{
			_tracks.push( url );
			if ( AUTOPLAY && !isPlaying() ) play();
		}
		
		public function addTracks( urls:Array ):void
		{
			var n:int = urls.length;
			for ( var i:int; i < n; ++i ) 
				_tracks.push( urls[ i ] );
		}
		
		public function play():void
		{
			if ( _playing ) return;
			
			if ( !_currentTrack )
			{
				_request = new URLRequest( _tracks[ _currentTrackIndex ] );
				_soundManager.load( _request );
				_currentTrack = _soundManager.play();
				if ( !_currentTrack.hasEventListener( Event.SOUND_COMPLETE ) ) _currentTrack.addEventListener( Event.SOUND_COMPLETE, onSoundComplete );
			}
			else _currentTrack = _soundManager.play( _bufferPosition );
			
			_playing = true;
			
			dispatchEvent( _playEvent );
		}
		
		public function stop():void
		{
			_bufferPosition = 0;
			_currentTrack.stop();
			_playing = false;
			
			dispatchEvent( _stopEvent );
		}
		
		public function pause():void
		{
			_bufferPosition = _currentTrack.position;
			_currentTrack.stop();
			_playing = false;
			
			dispatchEvent( _stopEvent );
		}
		
		public function isPlaying():Boolean { return this._playing; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tracksCount():int { return _tracks.length; }
		
	}
	
}