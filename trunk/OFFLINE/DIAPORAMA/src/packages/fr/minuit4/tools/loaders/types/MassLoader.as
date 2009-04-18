
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.tools.loaders.types 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import fr.minuit4.tools.loaders.BasicLoader;
	
	public class MassLoader extends BasicLoader
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loader:Loader;
		
		private var _itemsToLoad:Array;
		private var _itemsLoaded:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Creates a loader that can load a list of files.
		 * To load an unique file, this loader is not the best way, you should refer to ImageLoader or TextLoader class.
		 * Call the addItem method or addItems method to add url to load. Then, call the loadNext method to load the files by order.
		 * @param	isPersistent	Boolean	If false, all the data loaded will expire after the call of the destroy method.
		 */
		public function MassLoader( isPersistent:Boolean = false ) 
		{
			super( isPersistent );
			
			_itemsLoaded = [];
			_itemsToLoad = [];
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.INIT, onInit );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Method called after the onComplete event */
		protected override function setItemLoaded():void
		{
			_itemLoaded = _loader.contentLoaderInfo.content;
			_itemsLoaded[ _request.url ] = _itemLoaded;
			
			_itemsLoaded.push( _itemLoaded );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Add an item to the download queue list.
		 * @param	url	String	An url to load.
		 */
		public function addItem( url:String ):void
		{
			_itemsToLoad.push( url );
		}
		
		/**
		 * Add items to the download queue list.
		 * @param	urls	Array	A list of items which have to be loaded.
		 */
		public function addItems( urls:Array ):void
		{
			var n:int = urls.length;
			for ( var i:int; i < n; ++i )
				_itemsToLoad.push( urls[ i ] );
		}
		
		/**
		 * Load a file.
		 * This method should not be use with the MassLoader object.
		 * @param	url	String	The url of the file to load.
		 */
		public override function load( url:String ):void
		{
			super.load( url );
			_loader.load( _request );
		}
		
		/** Load the next item of the queue. */
		public function loadNext():void
		{
			if ( !hasNext() )
				return;
			
			load( _itemsToLoad[ loadedCount ] );
		}
		
		/** Return true if the loader still have items to load */
		public function hasNext():Boolean
		{
			if ( !itemsCount || ( itemsCount > 0 && itemsCount == loadedCount ) )
				return false
			
			return true;
		}
		
		/**
		 * This method reinitialiaze the loader.
		 * @param	cleanHistoric	Boolean	The loader's historic will be clean if this param is set on true.
		 */
		public override function clean( cleanHistoric:Boolean = false ):void
		{
			super.clean( cleanHistoric );
			
			var i:int = _itemsLoaded.length;
			while ( --i > -1 )
				if ( _itemsLoaded[ i ] is Bitmap ) Bitmap( _itemsLoaded[ i ] ).bitmapData.dispose();
			
			_itemsLoaded = [];
			_itemsToLoad = [];
			
			if ( _itemLoaded is Bitmap ) Bitmap( _itemLoaded ).bitmapData.dispose();
			_itemLoaded = null;
		}
		
		/**
		 * Get the list of items loaded.
		 * @return	Array
		 */
		public function getItemsLoaded():Array
		{
			return _itemsLoaded;
		}
		
		/** 
		 * Destroy the loader to save memory. If the isPersistent variable is false, no more data will be linked to the loader.
		 * After the call of this method, the loader will be unable to use.
		 */
		public override function destroy():void
		{
			super.destroy();
			
			_loader.contentLoaderInfo.removeEventListener( Event.INIT, onInit );
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			
			try { _loader.close(); }
			catch ( e:Error ) { }
			
			_loader = null;
			
			if ( !_isPersistent )
			{
				var i:int = _itemsLoaded.length;
				while ( --i > -1 )
					if ( _itemsLoaded[ i ] is Bitmap ) Bitmap( _itemsLoaded[ i ] ).bitmapData.dispose();
				
				_itemsLoaded = null;
				
				if ( _itemLoaded is Bitmap ) Bitmap( _itemLoaded ).bitmapData.dispose();
				_itemLoaded = null;
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/** Return the number of items which are in the list to be loaded */
		public function get itemsCount():int
		{
			return _itemsToLoad.length;
		}
		
		/** Return the number of loaded item */
		public function get loadedCount():int
		{
			return _itemsLoaded.length;
		}
		
	}
	
}