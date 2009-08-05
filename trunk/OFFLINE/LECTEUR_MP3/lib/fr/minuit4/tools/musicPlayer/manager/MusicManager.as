
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.manager 
{
	
	public class MusicManager 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:MusicManager;
		
		private var _tracks:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MusicManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use getInstance() methode instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
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
			
		}
		
		public function prevTrack():void
		{
			
		}
		
		public function addTrack( url:String ):void
		{
			_tracks.push( url );
		}
		
		public function addTracks( urls:Array ):void
		{
			var n:int = urls.length;
			for ( var i:int; i < n; ++i )
				_tracks.push( urls[ i ] );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tracksCount():int { return _tracks.length; }
		
	}
	
}