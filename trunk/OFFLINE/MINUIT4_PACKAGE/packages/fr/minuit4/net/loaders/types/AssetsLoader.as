
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 18.09.09		0.2		Floz		+ Correction de la méthode dispose() : le bitmapdata d'un objet bitmap n'est plus supprimé après l'appel.
 * 17.09.09		0.2		Floz		+ Ajout de la méthode execute
 * 15.09.09		0.2		Floz		+ Ajout de méthodes de AbstractLoader :
 * 										> register();
 * 										> unregister();
 * 									Qui permettent de gérer l'objet Loader.
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders.types 
{
	import fr.minuit4.net.loaders.AbstractLoader;

	import flash.display.Bitmap;
	import flash.display.Loader;

	public class AssetsLoader extends AbstractLoader
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _loader:Loader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Creates a loader that can load movie files such as SWF, PNG, JPG...
		 * To load text file, you must use the TextLoader object.
		 * Call the load() method and pass an url as parameter to launch the loader.
		 * @param	isPersistent	Boolean	If false, all the data loaded will expire after the call of the destroy method.
		 */
		public function AssetsLoader( url:String = null, isPersistent:Boolean = false ) 
		{
			super( url, isPersistent );
			
			_loader = new Loader();
			register( _loader.contentLoaderInfo );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Method called after the onComplete event */
		protected override function setItemLoaded():void
		{
			_itemLoaded = _loader.contentLoaderInfo.content;
			_itemsLoadedByURL[ _request.url ] = _itemLoaded;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Load a file.
		 * @param	url	String	The url of the file to load.
		 */
		public override function load( url:String = null ):void
		{
			super.load( url );
			_loader.load( _request );
		}
		
		/**
		 * This method reinitialiaze the loader.
		 * @param	cleanHistoric	Boolean	The loader's historic will be clean if this param is set on true.
		 */
		public override function clean( cleanHistoric:Boolean = false ):void
		{
			super.clean( cleanHistoric );
			
			if( _itemLoaded is Bitmap ) Bitmap( _itemLoaded ).bitmapData.dispose();
				_itemLoaded = null;
		}
		
		/** 
		 * Destroy the loader to save memory. If the isPersistent variable is false, no more data will be linked to the loader.
		 * After the call of this method, the loader will be unable to use.
		 */
		public override function dispose():void
		{
			super.dispose();
			
			try { _loader.unload(); _loader.close();  } // TODO: Si couille, check au niveau du unload. J'ai pas confiance.
			catch ( e:Error ) { }
			
			unregister();
			_loader = null;
			
			if ( !_isPersistent )
				_itemLoaded = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}