
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * 
 * Version log :
 * 21.09.09		0.2		Floz		+ Renommage en DataLoader
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

	import flash.net.URLLoader;

	public class DatasLoader extends AbstractLoader
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _loader:URLLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Creates a loader that can load movie files such as XML...
		 * To load Movie files, you must use the TextLoader object.
		 * Call the load() method and pass an url as parameter to launch the loader.
		 * @param	isPersistent	Boolean	If false, all the data loaded will expire after the call of the destroy method.
		 */
		public function DatasLoader( url:String = null, isPersistent:Boolean = false ) 
		{
			super( url, isPersistent );
			
			_loader = new URLLoader();
			register( _loader );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Method called after the onComplete event */
		protected override function setItemLoaded():void
		{
			super.setItemLoaded();
			_itemLoaded = _loader.data;
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
		 * Destroy the loader to save memory. If the isPersistent variable is false, no more data will be linked to the loader.
		 * After the call of this method, the loader will be unable to use.
		 */
		public override function dispose():void
		{
			super.dispose();
			
			try { _loader.close(); }
			catch ( e:Error ) { }
			
			unregister();
			_loader = null;
			
			if ( !_isPersistent )
				_itemLoaded = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}