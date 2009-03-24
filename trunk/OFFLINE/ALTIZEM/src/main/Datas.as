
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Datas extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _request:URLRequest;
		private var _loader:URLLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Datas() 
		{
			_request = new URLRequest();
			_loader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, onComplete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onComplete(e:Event):void 
		{
			var _xml:XML = XML( e.currentTarget.data );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "Datas.onIOError > " + _request.url );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function load( url:String ):void
		{
			_request.url = url;
			_loader.load( _request );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}