
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
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
	import flash.utils.ByteArray;
	
	public class CameraParamsLoader extends EventDispatcher
	{
		// - CONST -----------------------------------------------------------------------
		
		public static const CAMERA_PARAMS_LOAD:String = "camera_params_load";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _request:URLRequest;
		private var _loader:URLLoader;
		
		private var _cameraParams:ByteArray;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function CameraParamsLoader() 
		{
			_request = new URLRequest();
			_loader = new URLLoader( _request );
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );	
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLoadComplete(e:Event):void 
		{
			_loader.removeEventListener( Event.COMPLETE, onLoadComplete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			_cameraParams = _loader.data;
			
			dispatchEvent( new Event( CameraParamsLoader.CAMERA_PARAMS_LOAD ) );
			_loader = null;
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "CameraParamsLoader.onIOError > " + _request.url );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function load( url:String ):void
		{
			_request.url = url;
			_loader.load( _request );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function getCameraParams():ByteArray { return _cameraParams; }
		
	}
	
}