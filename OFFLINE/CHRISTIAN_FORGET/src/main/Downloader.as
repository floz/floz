
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
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Downloader extends EventDispatcher
	{
		private var list:Array;
		
		private var request:URLRequest;
		private var loader:Loader;
		
		private var image:BitmapData;
		
		public function Downloader() 
		{
			list = [];
			
			request = new URLRequest();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			image = Bitmap( e.currentTarget.content ).bitmapData;
			list.shift();
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "onIOError : " + request.url );
		}
		
		// PRIVATE
		
		private function check( url:String ):Boolean
		{
			var idx:int = -1;
			var n:int = list.length;
			for ( var i:int; i < n; i++ )
				if ( list[ i ] == url ) idx = i;
			
			if ( idx >= 0 ) 
			{
				list.unshift( list.splice( idx, 1 ) );
				return false;
			}
			
			return true;
		}
		
		// PUBLIC
		
		public function add( url:String, download:Boolean ):void
		{
			list.push( url );
			if ( download ) load( url );
		}
		
		public function load( url:String ):void
		{
			if ( check( url ) ) list.unshift( url );
			
			request.url = url;
			loader.load( request );
		}
		
		public function hasNext():Boolean
		{ 
			if ( list[ 0 ] ) return true;
			return false;
		}
		
		public function getImage():BitmapData
		{
			return image;
		}
		
	}
	
}