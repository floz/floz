
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 17.09.09		0.2		Floz		+ Ajout de la méthode execute.
 * 									+ Correction des méthodes clean & dispose : les bitmapdata des objets bitmap chargé ne sont plus supprimés.
 * 15.09.09		0.2		Floz		+ Ajout de méthodes de AbstractLoader :
 * 										> register();
 * 										> unregister();
 * 									Qui permettent de gérer l'objet Loader.
 * 									+ Implémentation de l'interface IIterator : changement de nom de la méthode loadNext() qui devient next();
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders.types 
{
	import fr.minuit4.core.interfaces.IIterator;
	import fr.minuit4.net.loaders.AbstractLoader;

	import flash.display.Loader;

	public class MassLoader extends AbstractLoader implements IIterator
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _loader:Loader;
		
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
		public function MassLoader( url:String = null, isPersistent:Boolean = false ) 
		{
			super( url, isPersistent );
			
			_itemsLoaded = [];
			_itemsToLoad = [];
			
			_loader = new Loader();
			register( _loader.contentLoaderInfo );
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
		public override function load( url:String = null ):void
		{
			super.load( url );
			_loader.load( _request );
		}
		
		/** Load the next item of the queue. */
		public function loadNext():void
		{
			next();
		}
		
		/** Load the next item of the queue. */
		public function next():void
		{
			if ( !hasNext() )
				return;
			
			load( _itemsToLoad[ loadedCount ] );
		}
		
		/** Return true if the loader still have items to load */
		public function hasNext():Boolean
		{
			if ( !itemsCount || ( itemsCount > 0 && itemsCount == loadedCount ) )
				return false;
			
			return true;
		}
		
		/**
		 * This method reinitialiaze the loader.
		 * @param	cleanHistoric	Boolean	The loader's historic will be clean if this param is set on true.
		 */
		public override function clean( cleanHistoric:Boolean = false ):void
		{
			super.clean( cleanHistoric );
			
			_itemsLoaded = [];
			_itemsToLoad = [];
			
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
		public override function dispose():void
		{
			super.dispose();
			
			try { _loader.unload(); _loader.close(); } // TODO: Si couille, check au niveau du unload. J'ai pas confiance.
			catch ( e:Error ) { }
			
			unregister();
			_loader = null;
			
			if ( !_isPersistent )
			{
				_itemsLoaded = null;
				_itemsToLoad = null;
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