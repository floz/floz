
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders.types 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import fr.minuit4.net.loaders.BasicLoader;
	
	public class MovieLoader extends BasicLoader
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
		public function MovieLoader( isPersistent:Boolean = false ) 
		{
			super( isPersistent );
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.INIT, onInit );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
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
		public override function load( url:String ):void
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
				if( _itemLoaded is Bitmap ) Bitmap( _itemLoaded ).bitmapData.dispose();
				_itemLoaded = null;
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}