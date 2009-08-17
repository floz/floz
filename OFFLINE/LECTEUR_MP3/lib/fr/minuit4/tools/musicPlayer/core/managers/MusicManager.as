﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	public class MusicManager extends EventDispatcher
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const AUTOPLAY:Boolean = false;
		
		private const _playEvent:MusicEvent = new MusicEvent( MusicEvent.PLAY );
		private const _stopEvent:MusicEvent = new MusicEvent( MusicEvent.STOP );
		private const _pauseEvent:MusicEvent = new MusicEvent( MusicEvent.PAUSE );
		private const _songLoadedEvent:MusicEvent = new MusicEvent( MusicEvent.SONG_LOADED );
		private const _id3LoadedEvent:MusicEvent = new MusicEvent( MusicEvent.ID3_LOADED );
		private const _volumeChangedEvent:MusicEvent = new MusicEvent( MusicEvent.VOLUME_CHANGED );
		private const _progressEvent:ProgressEvent = new ProgressEvent( ProgressEvent.PROGRESS );
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:MusicManager;
		
		private var _songs:Array;
		private var _currentSong:SoundChannel;
		private var _soundManager:Sound;
		private var _request:URLRequest;
		private var _currentSongIndex:int;
		private var _bufferPosition:Number = 0;
		private var _songDuration:Number;
		
		private var _volume:SoundTransform;
		private var _bufferVolume:Number;
		private var _mute:Boolean;
		
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
			_currentSong = null;
			
			initSoundManager();			
			nextTrack();
		}
		
		private function onLoadProgress( e:ProgressEvent ):void 
		{
			_progressEvent.bytesLoaded = _soundManager.bytesLoaded;
			_progressEvent.bytesTotal = _soundManager.bytesTotal;
			
			dispatchEvent( _progressEvent );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			_songDuration = _soundManager.length;
			_songs[ _currentSongIndex ].duration = _songDuration;
			
			dispatchEvent( _songLoadedEvent );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "MusicManager.onIOError : " + _songs[ _currentSongIndex ] );
		}
		
		private function onID3(e:Event):void 
		{
			dispatchEvent( _id3LoadedEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_songs = [];
			_volume = new SoundTransform();
			
			initSoundManager();
		}
		
		private function initSoundManager():void
		{
			if ( isPlaying() ) stop();
			
			if ( _soundManager )
			{
				try { _soundManager.close(); }
				catch ( e:Error ) {}
				
				_soundManager.removeEventListener( ProgressEvent.PROGRESS, onLoadProgress );
				_soundManager.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
				_soundManager.removeEventListener( Event.COMPLETE, onLoadComplete );
				_soundManager.removeEventListener( Event.ID3, onID3 );
			}
			
			_soundManager = new Sound();
			_soundManager.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_soundManager.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_soundManager.addEventListener( Event.COMPLETE, onLoadComplete );
			_soundManager.addEventListener( Event.ID3, onID3 );
			
			_currentSong = null;
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
		
		/**
		 * Switch to the next track.
		 * If the current song is the last of the list, the first will be selected.
		 */
		public function nextTrack():void
		{
			_currentSongIndex = _currentSongIndex + 1 >= songsCount ? 0 : _currentSongIndex + 1;
			initSoundManager();
			play();
		}
		
		/**
		 * Switch to the previous track.
		 * If the current song is the first of the list, the last will be selected.
		 */
		public function prevTrack():void
		{
			_currentSongIndex = _currentSongIndex - 1 >= 0 ? _currentSongIndex - 1 : songsCount - 1;
			initSoundManager();
			play();
		}
		
		/**
		 * Add a song at the list.
		 * @param	song	Object	An object containing the url of the song and his duration.
		 * If no duration is given, it will automaticaly been attribute after the song loading.
		 * The object must be write like this : { url: String, duration: Number (milliseconds) }
		 */
		public function addSong( song:Object ):void
		{
			_songs.push( song );
		}
		
		/**
		 * Add multiple songs at the list.
		 * @param	songs	Array	An array which contains multiple objects holding the url and the duration of the song.
		 * The object must be write like this : { url: String, duration: Number (milliseconds) }.
		 * The duration parameter is facultative.
		 */
		public function addSongs( songs:Array ):void
		{
			var n:int = songs.length;
			for ( var i:int; i < n; ++i ) 
				_songs.push( songs[ i ] );
		}
		
		/**
		 * Play the current song.
		 */
		public function play():void
		{
			if ( !_currentSong )
			{
				var song:Object = _songs[ _currentSongIndex ];
				_songDuration = song.duration || 0;				
				_request = new URLRequest( song.url );
				
				_soundManager.load( _request );
				_currentSong = _soundManager.play();
				_currentSong.addEventListener( Event.SOUND_COMPLETE, onSoundComplete );
			}
			else 
			{
				_currentSong = _soundManager.play( _bufferPosition );
				_currentSong.addEventListener( Event.SOUND_COMPLETE, onSoundComplete );
			}
			
			_playing = true;
			
			dispatchEvent( _playEvent );
		}
		
		/**
		 * Jump to the percent p of the song.
		 * @param	percent	Number	The percent of the song.
		 */
		public function moveTo( percent:Number ):void
		{
			var position:Number = percent * ( _songDuration || _soundManager.length );
			_bufferPosition = position;
			
			if ( isPlaying() )
			{
				_currentSong.stop();
				play();
			}
		}
		
		/**
		 * Jump to the second s of the song.
		 * @param	seconds	Number	The number of seconds.
		 */
		public function moveToSecond( seconds:Number ):void
		{
			_bufferPosition = seconds;
		}
		
		/**
		 * Stop the reading of any songs.
		 */
		public function stop():void
		{
			if ( !_currentSong ) return;
			
			_bufferPosition = 0;
			_currentSong.stop();
			_playing = false;
			
			dispatchEvent( _stopEvent );
		}
		
		/**
		 * Pause the reading of the current song.
		 */
		public function pause():void
		{
			_bufferPosition = _currentSong.position;
			_currentSong.stop();
			_playing = false;
			
			dispatchEvent( _pauseEvent );
		}
		
		public function setVolume( percent:Number ):void
		{
			if ( percent > 1 ) percent = 1;
			if ( percent < 0 ) percent = 0;
			
			_volume.volume = percent;
			SoundMixer.soundTransform = _volume;
			
			if ( percent == 0 )
			{
				_mute = true;
				_bufferVolume = 0;
			}
			else _mute = false;
			
			dispatchEvent( _volumeChangedEvent );
		}
		
		public function getVolume():Number { return _volume.volume; }
		
		public function mute():void
		{
			_mute = true;
			
			_bufferVolume = _volume.volume;			
			_volume.volume = 0;
			SoundMixer.soundTransform = _volume;
			
			dispatchEvent( _volumeChangedEvent );
		}
		
		public function unmute():void
		{
			_mute = false;			
			setVolume( _bufferVolume );			
		}
		
		public function destroy():void
		{
			// TODO
		}
		
		public function isPlaying():Boolean { return this._playing; }
		
		public function isMute():Boolean { return this._mute; }
		
		public function getCurrentArtist():String { return _soundManager.id3.artist; }
		
		public function getCurrentSong():String { return _soundManager.id3.songName; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get songsCount():int { return _songs.length; }
		
		public function get songPercent():Number
		{ 
			var percent:Number;
			if ( isPlaying() )
				percent = ( _currentSong.position / _songDuration ) || ( _currentSong.position / _soundManager.length );
			else
				percent = _bufferPosition / ( _songDuration || _soundManager.length );
			
			if ( percent < 0 ) percent = 0;
			if ( percent > 1 ) percent = 1;
			
			return percent || 0; 
		}
		
	}
	
}