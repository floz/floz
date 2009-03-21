package main
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class ImageLoader extends EventDispatcher
	{
		private var _request:URLRequest;
		private var _loader:Loader;
		private var _progressEvent:ProgressEvent;
		
		private var _percent:Number;
		private var _image:Bitmap;
		
		public function ImageLoader()
		{
			_request = new URLRequest();
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			_progressEvent = new ProgressEvent( ProgressEvent.PROGRESS );
		}
		
		// EVENTS
		
		private function onComplete( e:Event ):void
		{
			_image = _loader as Bitmap;
			
			dispatchEvent( new Event( Event.COMPLETE ) );
			
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader = null;
		}
		
		private function onProgress( e:ProgressEvent ):void
		{
			_percent = e.bytesLoaded * 100 / e.bytesTotal;
			dispatchEvent( _progressEvent );
		}
		
		private function onIOError( e:IOErrorEvent ):void
		{
			trace( "ImageLoader.onIOError > " + _request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function load( url:String ):void
		{
			_request.url = url;
			_loader.load( _request );
		}
		
		public function getImage():Bitmap { return _image; }
		public function getPercent():int { return _percent; }

	}
}