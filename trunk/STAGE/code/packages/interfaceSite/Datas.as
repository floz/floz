package interfaceSite 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Datas extends EventDispatcher
	{
		static public const COMPLETE:String = "complete";
		
		private var _request:URLRequest;
		private var loader:URLLoader;
		
		private var xml:XML;
		
		public function Datas( url:String ) 
		{
			_request = new URLRequest( url );
			loader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, onComplete );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onComplete(e:Event):void 
		{
			xml = XML( URLLoader( e.target ).data );
			
			dispatchEvent( new Event( Datas.COMPLETE ) );
			
			loader.removeEventListener( Event.COMPLETE, onComplete );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "Datas.onIOError : ", _request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function load():void
		{
			loader.load( _request );
		}
		
		public function getRubs():Array
		{
			var a:Array = [];
			
			var x:XML;
			for each( x in xml.rubrique ) a.push( [ x.@name ] );
			
			return a;
		}
		
		public function getProjs():Array
		{
			var a:Array = [];
			
			var x:XML;
			for each( x in xml.rubrique.projet ) a.push( [ x.@name ] );
			
			return a;
		}
		
		public function set request(value:URLRequest):void 
		{
			_request = value;
		}
		
	}
	
}