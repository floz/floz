
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class Downloader extends EventDispatcher 
	{
		public static const ITEM_LOADED:String = "item_loaded";
		private var aUrls:Array;
		private var aDownloaded:Array;
		private var request:URLRequest;
		private var loader:Loader;
		
		public function Downloader() 
		{
			aUrls = [];
			aDownloaded = [];
			
			request = new URLRequest();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onComplete(e:Event):void 
		{
			var bd:BitmapData;
			if ( e.currentTarget.content is Bitmap ) bd = Bitmap( e.currentTarget.content ).bitmapData;
			else bd = new BitmapData( 0, 0 );
			
			aDownloaded.push( bd );
			
			dispatchEvent( new Event( Downloader.ITEM_LOADED ) );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "Downloader.onIOError : " + request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function add( url:String ):void
		{
			aUrls.push( url );
		}
		
		public function addURLs( urls:Array ):void
		{
			aUrls = [];
			
			var a:Array = urls;
			while ( a.length ) aUrls.push( a.shift() );
		}
		
		public function clear():void
		{
			var n:int = aDownloaded.length;
			for ( var i:int; i < n; i++ )
			{
				aDownloaded[ i ].dispose;
				aDownloaded[ i ] = null;
			}
			aDownloaded = [];
		}
		
		public function load():void
		{			
			request.url = aUrls[ currentCount ];
			loader.load( request );
		}
		
		public function loadNext():void
		{
			if ( hasNext() ) load();
		}
		
		public function hasNext():Boolean
		{
			if ( !totalCount || currentCount == totalCount ) return false;
			return true;
		}
		
		public function getLastItem():BitmapData
		{
			return aDownloaded[ totalCount - 1 ];
		}
		
		public function get currentCount():int
		{
			return aDownloaded.length;
		}
		
		public function get totalCount():int
		{
			return aUrls.length;
		}
		
	}
	
}