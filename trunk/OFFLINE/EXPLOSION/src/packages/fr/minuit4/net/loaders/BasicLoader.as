
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 * 
 * Version log :
 * 
 * 15.04.09		0.1		Floz		+ First version
 */
package fr.minuit4.net.loaders
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class BasicLoader extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _isPersistent:Boolean;
		protected var _request:URLRequest;
		private var _initEvent:Event;
		private var _progressEvent:ProgressEvent;
		private var _completeEvent:Event;
		protected var _itemsLoadedByURL:Dictionary;
		
		protected var _itemLoaded:*;
		
		protected var _alive:Boolean;
		protected var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * This class must not be instanciate but can be extends to create a specific loader. 
		 * @param	isPersistent	Boolean	If false, all the data loaded will expire after the call of the destroy method.
		 */
		public function BasicLoader( isPersistent:Boolean ) 
		{
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
		
		/** This method has to be call to save the data loaded. */
		protected function setItemLoaded():void
		{			
			// set the information loaded
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Load a file.
		 * @param	url	String	The url of the file to load.
		 */
		public function load( url:String ):void
		{
			if ( !_alive ) throw new Error( "The loader has been destroyed." );
			if ( _itemsLoadedByURL[ url ] ) 
			{
				_itemLoaded = _itemsLoadedByURL[ url ];
				dispatchEvent( new Event( Event.COMPLETE ) );
				return;
			}
			
			_request.url = url;
			_running = true;
		}
		
		/** 
		 * Destroy the loader to save memory. If the isPersistent variable is false, no more data will be linked to the loader.
		 * After the call of this method, the loader will be unable to use.
		 */
		public function destroy():void
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
		
		/** Return true if the loader can still be use. It won't be if the destroy method has been called */
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
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}