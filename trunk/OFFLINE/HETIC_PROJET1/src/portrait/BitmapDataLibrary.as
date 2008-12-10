
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package portrait 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class BitmapDataLibrary extends EventDispatcher
	{
		public static const BITMAPDATA_LOADED:String = "bitmapdata_loaded";
		
		private var aBitmapDatasToLoad:Array;
		private var aBitmapDatasLoaded:Array;
		private var request:URLRequest;
		private var loader:Loader;
		
		public function BitmapDataLibrary() 
		{
			aBitmapDatasToLoad = [];
			aBitmapDatasLoaded = [];
			
			request = new URLRequest();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			var b:BitmapData;
			if ( e.currentTarget.content is Bitmap ) b = Bitmap( e.currentTarget.content ).bitmapData.clone();
			else b = new BitmapData( 0, 0 );
			
			aBitmapDatasLoaded.push( b );
			
			dispatchEvent( new Event( BitmapDataLibrary.BITMAPDATA_LOADED ) );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "BitmapDataLibrary.onIOError : " + request.url );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function add( url:String, name:String ):void
		{
			aBitmapDatasToLoad.push( { url: url, name: name } );
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
		
		public function load():void
		{
			if ( alreadyUsed ) clear( true );
			
			request.url = aBitmapDatasToLoad[ 0 ];
			loader.load( request) ;
		}
		
		public function hasNext():Boolean
		{
			if ( toLoadCount ) return true;
			return false;
		}
		
		public function loadNext():void
		{
			if ( hasNext() ) load();
		}
		
		public function search( name:String ):BitmapData
		{
			if ( !loadedCount ) return;
			
			var i:int;
			var n:int = loadedCount;
			for ( i; i < n; i++ )
				if ( aBitmapDatasLoaded[ i ].name == name ) return aBitmapDatasLoaded[ i ];
			
			trace ( "Le nom indiqué ne correspond à aucun fichier téléchargé : BitmapDataLibrary.search()" );
			return null;
		}
		
		// GETTERS & SETTERS
		
		public function get toLoadCount():int
		{
			return aBitmapDatasToLoad.length;
		}
		
		public function get loadedCount():int
		{
			return aBitmapDatasLoaded.length;
		}
		
	}
	
}