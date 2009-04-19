
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	public class Datas extends EventDispatcher 
	{
		private var request:URLRequest;
		private var loader:URLLoader;
		
		private var xml:XML;
		
		public function Datas( url:String ) 
		{
			request = new URLRequest( url );
			loader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			xml = XML( e.currentTarget.data );
			
			dispatchEvent( new Event( Event.COMPLETE ) );
			
			loader.removeEventListener( Event.COMPLETE, onLoadComplete );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "Datas.onIOError : " + request.url );
		}
		
		// PRIVATE	
		
		// PUBLIC
		
		public function load():void
		{
			loader.load( request );
		}
		
		public function getUrls():Array
		{
			var a:Array = [];
			
			var x:XML;
			for each( x in xml.file ) a.push( xml.path.@swf + x.@src );
			
			return a;
		}
		
		public function getInfos():Array
		{
			var a:Array = [];
			
			var x:XML;
			for each( x in xml.file ) a.push( { type: x.@type, desc: x.@desc } );
			
			return a;
		}
		
	}
	
}