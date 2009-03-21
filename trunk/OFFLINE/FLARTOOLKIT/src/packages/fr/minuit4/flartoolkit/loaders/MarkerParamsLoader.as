
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.flartoolkit.loaders 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class MarkerParamsLoader extends EventDispatcher
	{		
		// - CONST -----------------------------------------------------------------------
		
		public static const MARKER_PARAMS_LOAD:String = "marker_params_load";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _request:URLRequest;
		private var _loader:URLLoader;
		
		private var _markerParams:String;
		
		private var _activated:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MarkerParamsLoader() 
		{
			_request = new URLRequest();
			_loader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			_activated = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLoadComplete(e:Event):void 
		{
			_markerParams = URLLoader( e.currentTarget ).data;
			
			dispatchEvent( new Event( MARKER_PARAMS_LOAD ) );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "MarkerParamsLoader.onIOError > " + _request.url );			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function load( url:String ):void
		{
			if ( !_activated )
				throw new Error( "This loader has been deactivated and it's not able to load anymore." );
				
			_request.url = url;
			_loader.load( _request );
		}
		
		public function deactivate():void
		{
			_loader.removeEventListener( Event.COMPLETE, onLoadComplete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader = null;
			
			_activated = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function getMarkerParams():String { }
		
	}
	
}