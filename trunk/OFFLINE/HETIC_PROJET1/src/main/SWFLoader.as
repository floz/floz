
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class SWFLoader extends MovieClip 
	{
		private var aItemsToLoad:Array;
		private var aItemsLoaded:Array;
		private var request:URLRequest;
		private var loader:Loader;
		
		private var alreadyUsed:Boolean;
		
		public function SWFLoader() 
		{
			aItemsToLoad = [];
			aItemsLoaded = [];
			
			request = new URLRequest();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		}
		
		// EVENTS
		
		private function onLoadComplete(e:Event):void 
		{
			if ( e.currentTarget.content is MovieClip )
			{
				var o:Object = aItemsToLoad.shift();
				aItemsLoaded = { swf: e.currentTarget.content, name: o.name };
				
				dispatchEvent( new Event( Event.COMPLETE ) );
				
				o = null;
			}
			else throw new TypeError( "Le fichier téléchargé n'est pas un SWF : SWFLoader.onLoadComplete" );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "onIOError : " + request.url );
		}
		
		// PRIVATE	
		
		// PUBLIC
		
		public function add( url:String, name:String ):void
		{
			aItemsToLoad.push( { url: url, name: name } );
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
			
			request.url = aItemsToLoad[ 0 ];
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
		
		public function search( name:String ):void
		{
			if ( !loadedCount ) return;
			
			var i:int;
			var n:int = loadedCount;
			for ( i; i < n; i++ )
				if ( aItemsLoaded[ i ].name == name ) return aItemsLoaded[ i ];
			
			trace ( "Le nom indiqué ne correspond à aucun fichier téléchargé : SWFLoader.search()" );
			return null;
		}
		
		// GETTERS & SETTERS
		
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