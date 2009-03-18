
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.flartoolkit.loaders 
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
		
		public function CameraParamsLoader( url:String ) 
		{
			_request = new URLRequest( url );
			_loader = new URLLoader( _request );
			_loader = new URLLoader( _request );
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener( Event.COMPLETE, onLoadComplete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_loader.load();			
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
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function getCameraParams():ByteArray { return _cameraParams; }
		
	}
	
}