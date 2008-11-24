
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import fr.minuit4.tools.FPS;
	
	public class Main extends MovieClip
	{
		private var _datas:Datas;
		
		public function Main() 
		{
			var _engine:Engine = new Engine( 640, 360 );
			addChild( _engine );
			
			var _fps:FPS = new FPS();
			addChild( _fps );
			
			_datas = new Datas( "xml/files.xml" );
			_datas.addEventListener( Event.COMPLETE, onComplete );
			_datas.load();
		}
		
		private function onComplete(e:Event):void 
		{
			
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}