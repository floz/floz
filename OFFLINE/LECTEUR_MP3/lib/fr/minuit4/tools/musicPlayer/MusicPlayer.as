
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.net.loaders.types.TextLoader;
	
	public class MusicPlayer extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _xmlLoader:TextLoader;
		
		private var _playlist:XML;
		private var _config:XML;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MusicPlayer() 
		{
			_xmlLoader = new TextLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, onConfigComplete );
			_xmlLoader.load( path_xml + config_xml );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onConfigComplete(e:Event):void 
		{
			_xmlLoader.removeEventListener( Event.COMPLETE, onConfigComplete );
			_config = XML( _xmlLoader.getItemLoaded() );
			
			_xmlLoader.addEventListener( Event.COMPLETE, onPlaylistInfosComplete );
			_xmlLoader.load( path_xml + playlist_xml );			
		}
		
		private function onPlaylistInfosComplete(e:Event):void 
		{
			_xmlLoader.removeEventListener( Event.COMPLETE, onPlaylistInfosComplete );
			_playlist = XML( _xmlLoader.getItemLoaded() );
			
			trace( _config );
			trace( _playlist );
			
			build();
			
			_xmlLoader.destroy();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function build():void
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo ? loaderInfo.parameters[ "path_xml" ] : "assets/xml/"; }
		public function get playlist_xml():String { return loaderInfo ? loaderInfo.parameters[ "playlist_xml" ] : "playlist.xml"; }
		public function get config_xml():String { return loaderInfo ? loaderInfo.parameters[ "config_xml" ] : "config.xml"; }
		
	}
	
}