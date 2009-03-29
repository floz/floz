
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.loaders 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class BasicLoader extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _isPersistent:Boolean;
		protected var _request:URLRequest;
		private var _progressEvent:ProgressEvent;
		
		protected var _itemLoaded:*;
		
		protected var _alive:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function BasicLoader( isPersistent:Boolean ) 
		{
			_isPersistent = isPersistent;
			
			_request = new URLRequest();			
			_progressEvent = new ProgressEvent( ProgressEvent.PROGRESS );
			
			_alive = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		protected function onIOError( e:IOErrorEvent ):void
		{
			trace( "onIOError > " + _request.url );
		}
		
		protected function onInit( e:Event ):void
		{
			dispatchEvent( new Event( Event.INIT ) );
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
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function setItemLoaded():void
		{
			// set the information loaded
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function load( url:String ):void
		{
			if ( !_alive ) throw new Error( "The loader has been destroyed." );
			_request.url = url;
		}
		
		public function destroy():void
		{
			_alive = !_alive;
			_request = null;
			
			// destroy the loader
		}
		
		public function isAlive():Boolean { return _alive; }
		
		public function getItemLoaded():*
		{
			return _itemLoaded;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}