package com.gobzlite.sounds 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	/**
	 * Tools to manage your sound and music in your application.
	 * 
	 * Written by :
	 * @author DavidRonai
	 * 
	 * --------------------------
	 * + synthax
	 * --------------------------
	 * 
	 * SoundManager.volume = Number [0 ... 1];
	 * 
	 * SoundManager.loadSound( url, name, callback );
	 * SoundManager.loadSounds( urls:Array, names:Array, callback);
	 * 
	 * SoundManager.getSound( name );
	 * 
	 * SoundManager.unloadSound( name );
	 * SoundManager.unloadSounds( names:Array );
	 * SoundManager.unloadAllSound( );
	 * 
	 * ---------------------------
	 * + todo
	 * ---------------------------
	 *
	 * Manage sound group for different volume as : "fx" , "music" , "webcam", "etc..."
	 * 
	 * @version 0.3 : singleton -> static
	 * @version 0.2 : unload methods
	 * @version 0.1 : first implementation
	 * 
	 */
	public class SoundManager extends EventDispatcher
	{
		// GSounds
		static private var _sounds:Dictionary = new Dictionary();
		
		// load system
		static private var _loadList:Array = [];
		static private var _callback:Function;
		
		static private var _volume:Number = 1;
		static private var loadInProgress:Boolean;
		
		/**
		 * Singleton
		 */
		public function SoundManager()
		{
			throw new Error("You can't create an instance of SoundManager");
		}

		//xxxxxxxxxxxxxxxxxxxxxxxxxxx
		// Public load method
		//xxxxxxxxxxxxxxxxxxxxxxxxxxx
		
		/**
		 * Load a sound in the library.
		 * If other sound are actually loaded, load after.
		 * 
		 * @param	url			url to load
		 * @param	name		sound name in the library
		 * @param	callback	callback to 
		 */
		static public function loadSound( url:String, name:String, callback:Function = null ):void
		{
			if( callback != null )
				_callback = callback;
			
			var gSound:GSound = new GSound( url );
			
			_loadList.push( gSound );
			_sounds[ name ] = gSound;
			
			if ( !loadInProgress )
				startLoad();
		}
		
		/**
		 * Load multiple sounds in library
		 * 
		 * @param	urls		array contains String with url
		 * @param	names		array of same lenght as urls, else name by default is urls
		 * @param	callback	function call when all sound are load
		 */
		static public function loadSounds( urls:Array, names:Array, callback:Function = null):void
		{
			for ( var i:int = urls.length - (urls.length - names.length); i < urls.length; i++) {
				names[i] = urls[i];
			}
			
			for ( i = 0; i < urls.length; i++ ) {
				loadSound( urls[i], names[i] );
			}
			
			if ( callback != null)
				_callback = callback;
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxxxx
		// Internal loading method
		//xxxxxxxxxxxxxxxxxxxxxxxxxxx
		static private function startLoad():void
		{
			if ( loadInProgress )
				return;
			
			loadInProgress = true;
				
			var gs:GSound = _loadList.shift() as GSound;
			gs.addEventListener( Event.COMPLETE, onLoaded );
			gs.load();
		}		
		static private function onLoaded(e:Event):void 
		{
			e.target.removeEventListener( Event.COMPLETE, onLoaded );
			
			loadInProgress = false;
			
			if ( _loadList.length > 0 ) {
				startLoad();
			} 
			else {
				if ( _callback != null ){
					_callback();
					_callback = null;
				}
			}
		}
		
		//xxxxxxxxxxxxxxxxxxxxx
		// Unload sound
		//xxxxxxxxxxxxxxxxxxxxx
		
		static public function unloadSound( name:String ):void
		{
			var gs:GSound = getSound( name );
			if ( gs == null )
				return;
			gs.dispose();
			delete _sounds[name];
		}
		
		static public function unloadSounds( names:Array ):void
		{
			for ( var i:int = 0; i < names.length; i++)
				unloadSound( names[i] );
		}
		
		static public function unloadAllSounds():void
		{
			for (var key:Object in _sounds) {
				unloadSound( key as String );
			}
		}
		
		//xxxxxxxxxxxxxxxxxxxxx
		// Get a sound
		//xxxxxxxxxxxxxxxxxxxxx
	 
		/**
		 * Get a sound in the library
		 * 
		 * @param	name	Sound name in the library
		 * @return sound or null if sound doesn't exist.
		 */
		static public function getSound(name:String):GSound
		{
			if ( _sounds[name] != undefined )
				return _sounds[name];
			else 
				return null;
		}
		
		//xxxxxxxxxxxxxxxxxxxxx
		// Set volume
		//xxxxxxxxxxxxxxxxxxxxx
		
		static public function get volume():Number { return _volume; }
		static public function set volume( value:Number ):void 
		{
			if ( value < 0 )
				value = 0;
			for (var key:Object in _sounds) {
				_sounds[key as String].volume = value;
			}
			_volume = value;
		}
	}
}