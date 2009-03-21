
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
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
		// PRIVATE
		
		private var _request:URLRequest;
		private var _loader:URLLoader;
		
		private var _xml:XML;
		
		// PUBLIC 
		
		public function Datas()
		{
			_request = new URLRequest();
			_loader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, onComplete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onComplete( e:Event ):void
		{
			_xml = XML( e.currentTarget.data );
			
			dispatchEvent( new Event( Event.COMPLETE ) );
			
			_loader.removeEventListener( Event.COMPLETE, onComplete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader = null;
		}
		
		private function onIOError( e:IOErrorEvent ):void
		{
			trace( "Datas.onIOError > " + _request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function load( url:String ):void
		{
			_request.url = url;
			_loader.load( _request );
		}
		
		// GETTERS & SETTERS
		
		public function getPlanURL():String
		{
			return _xml.path.@plan;
		}
		
		public function getInfos():void
		{
			trace( "Datas.getInfos" );
		}

	}
}