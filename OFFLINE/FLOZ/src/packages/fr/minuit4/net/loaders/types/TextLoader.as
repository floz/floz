
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * 
 * Version log :
 * 
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders.types 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import fr.minuit4.net.loaders.BasicLoader;
	
	public class TextLoader extends BasicLoader
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
		public function TextLoader( isPersistent = false ) 
		{
			super( isPersistent );
			
			_loader = new URLLoader();
			_loader.addEventListener( Event.INIT, onInit );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.addEventListener( Event.COMPLETE, onComplete );
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
		public override function load( url:String ):void
		{
			super.load( url );
			_loader.load( _request );
		}
		
		/** 
		 * Destroy the loader to save memory. If the isPersistent variable is false, no more data will be linked to the loader.
		 * After the call of this method, the loader will be unable to use.
		 */
		public override function destroy():void
		{
			super.destroy();
			
			_loader.removeEventListener( Event.INIT, onInit );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.removeEventListener( Event.COMPLETE, onComplete );
			
			try { _loader.close(); }
			catch ( e:Error ) { }
			
			_loader = null;
			
			if ( !_isPersistent )
				_itemLoaded = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}