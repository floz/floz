
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package test_conf 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import fr.minuit4.core.commands.events.CommandEvent;
	import fr.minuit4.core.configuration.conf;
	
	public class TestConf extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TestConf() 
		{
			conf.addEventListener( ProgressEvent.PROGRESS, progressHandler, false, 0, true );
			conf.addEventListener( Event.COMPLETE, confCompleteHandler, false, 0, true );
			conf.load( "assets/xml/conf.xml" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function progressHandler(e:ProgressEvent):void 
		{
			trace( e.bytesLoaded / e.bytesTotal );
		}
		
		private function confCompleteHandler(e:Event):void 
		{
			trace( "conf complete !" );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}