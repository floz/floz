
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package table 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class ItemsLibrary extends EventDispatcher
	{
		public static const ITEM_LOADED:String = "item_loaded";
		
		private var aItemsToLoad:Array;
		private var aItemsLoaded:Array;
		private var request:URLRequest;
		private var loader:Loader;
		
		private var alreadyUsed:Boolean;
		
		public function ItemsLibrary() 
		{
			aItemsToLoad = [];
			aItemsLoaded = [];
			
			request = new URLRequest();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			var m:MovieClip
			if ( e.currentTarget.content is MovieClip ) m = MovieClip ( e.currentTarget.content );
			else m = new MovieClip();
			
			aItemsLoaded.push( m );
			
			alreadyUsed = true;
			
			dispatchEvent( new Event( ItemsLibrary.ITEM_LOADED ) );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "ItemsLibrary.onIOError : " + request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function add( url:String ):void
		{
			aItemsToLoad.push( url );
		}
		
		public function addItems( urls:Array ):void
		{
			var a:Array = urls;
			while ( a.length ) aItemsToLoad.push( a.shift() );
			
		}
		
		public function clear( renew:Boolean = false ):void
		{
			loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			loader = null;
			
			if ( renew )
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			}
		}
		
		public function dispose():void
		{
			var i:int;
			var n:int = aItemsLoaded.length;
			for ( i; i < n; i++ )
				aItemsLoaded[ i ] = null;
			
			aItemsLoaded = null;
			aItemsToLoad = null;
		}
		
		public function loadNext():void
		{
			if ( !hasNext() ) return;
			
			if ( alreadyUsed ) clear( true );
			
			request.url = aItemsToLoad[ loadedCount ];
			loader.load( request) ;
		}
		
		public function hasNext():Boolean
		{
			if ( !toLoadCount || toLoadCount == loadedCount ) return false;
			return true;
		}
		
		// GETTERS & SETTERS
		
		public function getLastItem():MovieClip
		{
			return aItemsLoaded[ loadedCount - 1 ];
		}
		
		public function get toLoadCount():int
		{
			return aItemsToLoad.length;
		}
		
		public function get loadedCount():int
		{
			return aItemsLoaded.length;
		}
		
	}
	
}