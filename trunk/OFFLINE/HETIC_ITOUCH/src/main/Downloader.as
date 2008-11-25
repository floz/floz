
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class Downloader extends EventDispatcher
	{
		public static const IMG_LOADED:String = "img_loaded";
		public static const SWF_LOADED:String = "swf_loaded";
		
		private var _list:Array;
		private var _request:URLRequest;
		private var _loader:Loader;
		
		public var lastItemDownloaded:Object;
		
		public function Downloader() 
		{
			_list = [];
			
			_request = new URLRequest();
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			var o:Object = _list.shift();
			
			lastItemDownloaded = { name: o.name, content: e.currentTarget.content };
			
			if ( e.currentTarget.content is Bitmap )
			{				
				dispatchEvent( new Event( Downloader.IMG_LOADED ) );				
				if ( hasNext() ) load();
			}
			else if ( e.currentTarget.content is MovieClip )
			{				
				dispatchEvent( new Event( Downloader.SWF_LOADED ) );				
				if ( hasNext() ) load();
			}
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "onIOError : "  + _request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function load():void
		{
			_request.url = _list[ 0 ].url;
			_loader.load( _request );
		}
		
		public function add( o:Object ):void
		{
			_list.push( o );
		}
		
		public function hasNext():Boolean
		{
			if ( _list[ 0 ] ) return true;
			return false;
		}
		
	}
	
}