
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import fr.minuit4.tools.FPS;
	
	public class Main extends MovieClip
	{
		private var _engine:Engine;
		//private var _downloader:Downloader;
		private var _datas:Datas;
		
		public function Main() 
		{
			_engine = new Engine( 980, 560 );
			addChild( _engine );
			
			var _fps:FPS = new FPS();
			addChild( _fps );
			
			//_downloader = new Downloader();
			
			_datas = new Datas( "xml/files.xml" );
			_datas.addEventListener( Event.COMPLETE, onComplete );
			_datas.load();
		}
		
		// EVENTS
		
		private function onComplete(e:Event):void 
		{
			_engine.init( _datas.getInfos() );
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}