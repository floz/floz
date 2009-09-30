
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 20.09.09		0.2		Floz		+ Implémentation de l'interface IDisposable.
 * 17.09.09		0.2		Floz		+ Implémentation de l'interface ICommand.
 * 									Les loaders peuvent donc être utilisé comme des commands qu'un objet Batch peut exécuter via la méthode execute();
 * 									+ La méthode load n'attend plus obligatoirement un paramètre url.
 * 									Celui ci peut être passé en paramètre au moment de l'instanciation ou via la méthode setUrl.
 * 15.09.09		0.2		Floz		+ Ajout de méthodes :
 * 										> register();
 * 										> unregister();
 * 									Qui permettent de gérer l'objet Loader.
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders
{
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.core.commands.ICommand;

	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class AbstractLoader extends EventDispatcher implements ICommand, IDisposable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _isPersistent:Boolean;
		protected var _request:URLRequest;
		private var _loadDispatcher:IEventDispatcher;
		private var _initEvent:Event;
		private var _progressEvent:ProgressEvent;
		private var _completeEvent:Event;
		protected var _itemsLoadedByURL:Dictionary;
		
		protected var _url:String;
		protected var _itemLoaded:*;
		
		protected var _alive:Boolean;
		protected var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * This class must not be instanciate but can be extends to create a specific loader. 
		 * @param	isPersistent	Boolean	If false, all the data loaded will expire after the call of the destroy method.
		 */
		public function AbstractLoader( url:String = null, isPersistent:Boolean = false ) 
		{
			_url = url;
			_isPersistent = isPersistent;
			
			_request = new URLRequest();
			_initEvent = new Event( Event.INIT );
			_progressEvent = new ProgressEvent( ProgressEvent.PROGRESS );
			_completeEvent = new Event( Event.COMPLETE );
			
			_itemsLoadedByURL = new Dictionary();
			
			_alive = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		protected function onIOError( e:IOErrorEvent ):void
		{
			trace( "onIOError > " + _request.url );
		}
		
		protected function onInit( e:Event ):void
		{
			dispatchEvent( _initEvent );
		}
		
		protected function onProgress( e:ProgressEvent ):void
		{
			_progressEvent.bytesLoaded = e.bytesLoaded;
			_progressEvent.bytesTotal = e.bytesTotal;
			
			dispatchEvent( _progressEvent );
		}
		
		protected function onComplete( e:Event ):void
		{
			setItemLoaded();
			_running = false;
			dispatchEvent( _completeEvent );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function register( ed:IEventDispatcher ):void
		{
			_loadDispatcher = ed;
			_loadDispatcher.addEventListener( Event.INIT, onInit );
			_loadDispatcher.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loadDispatcher.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loadDispatcher.addEventListener( Event.COMPLETE, onComplete );
		}
		
		protected function unregister():void
		{
			_loadDispatcher.removeEventListener( Event.INIT, onInit );
			_loadDispatcher.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loadDispatcher.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loadDispatcher.removeEventListener( Event.COMPLETE, onComplete );
			_loadDispatcher = null;
		}
		
		/** This method has to be call to save the data loaded. */
		protected function setItemLoaded():void
		{			
			// set the information loaded
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Load a file.
		 * @param	url	String	The url of the file to load. Facultatif
		 */
		public function load( url:String = null ):void
		{
			if ( !_alive ) throw new Error( "The loader has been destroyed." );
			if( url ) _url = url;
			if ( _itemsLoadedByURL[ _url ] ) 
			{
				_itemLoaded = _itemsLoadedByURL[ _url ];
				dispatchEvent( new Event( Event.COMPLETE ) );
				return;
			}
			
			_request.url = _url;
			_running = true;
		}
		
		/** 
		 * Destroy the loader to save memory. If the isPersistent variable is false, no more data will be linked to the loader.
		 * After the call of this method, the loader will be unable to use.
		 */
		public function dispose():void
		{
			_alive = !_alive;
			_request = null;
			
			_itemsLoadedByURL = null;
			
			// destroy the loader
		}
		
		/**
		 * This method reinitialiaze the loader.
		 * @param	cleanHistoric	Boolean	The loader's historic will be clean if this param is set on true.
		 */
		public function clean( cleanHistoric:Boolean = false ):void
		{
			if ( cleanHistoric ) 
			{
				_itemsLoadedByURL = null;
				_itemsLoadedByURL = new Dictionary();
			}
		}
		
		/**
		 * This method delete the historic of the file loaded..
		 * @param	url	String	The url reference of the file loaded.
		 */
		public function cleanURL( url:String ):void
		{
			if ( !_itemsLoadedByURL[ url ] ) 
				return;
			
			if ( _itemsLoadedByURL[ url ] is Bitmap ) Bitmap( _itemsLoadedByURL[ url ] ).bitmapData.dispose();
			_itemsLoadedByURL[ url ] = null;
		}
		
		public function execute():void
		{
			load( _url );
		}
		
		/** Return true if the loader can still be use. It won't be if the dispose method has been called */
		public function isAlive():Boolean { return _alive; }
		
		/** Return true if a load is performing */
		public function isRunning():Boolean { return _running; }
		
		/**
		 * By passing an url in param you can know if the file link to this adress has been already loaded.
		 * @param	url	String	The url of the file.
		 * @return	Boolean
		 */
		public function isItemLoaded( url:String ):Boolean { return _itemsLoadedByURL[ url ] ? true : false; }
		
		/**
		 * Return a file that has been load before.
		 * @param	url	The url that refer to the file.
		 * @return	*
		 */
		public function getItemByURL( url:String ):*
		{ 
			if ( !isItemLoaded( url ) ) 
				return null;
			
			return _itemsLoadedByURL[ url ];
		}
		
		/**
		 * Return the last item loaded.
		 * @return *
		 */
		public function getItemLoaded():*
		{
			return _itemLoaded;
		}
		
		/** 
		 * Set a new value to the url.
		 */
		public function setUrl( value:String ):void { _url = value; }
		
		/**
		 * Return the url who will be loaded by the loader.
		 * @return
		 */
		public function getUrl():String { return _url; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}