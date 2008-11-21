
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
		private var downloadedList:Array;
		
		private var request:URLRequest;
		private var loader:Loader;
		private var needToDispatch:Boolean;
		
		private var image:BitmapData;
		
		public function Downloader( length:int ) 
		{
			list = [];
			downloadedList = [];
			
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
			
			if ( !checkIfDownloaded( request.url, false ) ) downloadedList.push( { url: request.url, image: image } );
			trace ( downloadedList.length );
			
			if ( needToDispatch ) dispatchEvent( new Event( Event.COMPLETE ) );
			
			downloadNext();
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace ( "onIOError : " + request.url );
		}
		
		// PRIVATE
		
		/**
		 * Permet d'organiser la liste d'images à télécharger.
		 * @param	url	String	L'url du fichier à télécharger.
		 * @return
		 */
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
		
		/**
		 * Download l'élement suivant de la liste, s'il en existe un.
		 */
		private function downloadNext():void
		{
			if ( !hasNext() ) return;
			if ( !checkIfDownloadedAndAjust() ) return;
			
			needToDispatch = false;
			
			request.url = list[ 0 ];
			loader.load( request );
		}
		
		public function checkIfDownloadedAndAjust():Boolean
		{
			var i:int;
			var n:int = list.length;
			for ( i; i < n; i++ )
			{
				for each( var o:Object in downloadedList ) 
				{
					if ( o.url == list[ i ] ) 
					{
						list.splice( i, 1 );
						continue;
					} 					
				}
			}
			
			if ( hasNext() ) return true;
			return false;
		}
		
		// PUBLIC
		
		/**
		 * Ajoute un élement à la liste, et le download s'il l'est demandé.
		 * @param	url	String	L'url du fichier à télécharger.
		 * @param	download	Boolean	Si oui ou non on lance le téléchargement du fichier, après l'avoir ajouté à la liste.
		 */
		public function add( url:String, download:Boolean ):void
		{
			list.push( url );
			if ( download ) load( url );
		}
		
		/**
		 * Charge le fichier demandé.
		 * @param	url	String	L'url du fichier à télécharger.
		 */
		public function load( url:String ):void
		{
			if ( check( url ) ) list.unshift( url );
			
			needToDispatch = true;
			
			request.url = url;
			loader.load( request );
		}
		
		/**
		 * Vérifie s'il existe encore des élément à télécharger dans la liste. Renvoie True ou False.
		 * @return
		 */
		public function hasNext():Boolean
		{ 
			if ( list[ 0 ] ) return true;
			return false;
		}
		
		/**
		 * Vérifie si le fichier demandé a déjà été téléchargé.
		 * Si c'est le cas, ajoute l'image télécharger dans la variable image, afin d'être pouvoir récupérée via getImage();
		 * @param	url
		 * @return
		 */
		public function checkIfDownloaded( url:String, setImg:Boolean = true ):Boolean
		{
			for each( var o:Object in downloadedList ) 
			{
				if ( o.url == url ) 
				{
					if ( setImg ) image = o.image;
					return true;
				}
				continue;
			}
			return false;
		}
		
		/**
		 * Stop tous les download qui pourraient suivre.
		 */
		public function stop():void
		{
			list = [];
			trace ( "unload ! a surveiller !" );
			loader.unload(); // A surveiller
		}
		
		/**
		 * Récupère la dernier image téléchargée, ou sélectionnée.
		 * @return
		 */
		public function getImage():BitmapData
		{
			return image;
		}
		
	}
	
}