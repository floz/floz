
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
	
	public class BasicFLARLoaders extends EventDispatcher
	{
		// - CONST -----------------------------------------------------------------------
		
		public static const PARAMS_LOADED:String = "params_loaded";
		public static const LOADING:String = "loading";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cameraFile:String;
		private var _patternFile:String;
		private var _request:URLRequest;
		private var _loader:URLLoader;
		
		private var _cameraParams:ByteArray;
		private var _patternParams:String;
		
		private var _loading:Boolean;
		private var _loaded:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Objet de chargement d'un fichier de caméra et d'un marker
		 * @param	cameraFile
		 * @param	patternFile
		 */
		public function BasicFLARLoaders( cameraFile:String, patternFile:String ) 
		{
			_cameraFile = cameraFile;
			_patternFile = patternFile;
			
			_request = new URLRequest( _cameraFile );
			_loader = new URLLoader( _request );
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener( Event.COMPLETE, onCameraFileComplete );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOErrorEvent );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onCameraFileComplete(e:Event):void 
		{
			_loader.removeEventListener( Event.COMPLETE, onCameraFileComplete );
			
			_cameraParams = _loader.data;
			
			_request.url = _patternFile;
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener( Event.COMPLETE, onPatternFileComplete );
			_loader.load( _request );
		}
		
		private function onIOErrorEvent(e:IOErrorEvent):void 
		{
			trace( "FLARLoaders.onIOErrorEvent > " + _request.url );			
		}
		
		private function onPatternFileComplete(e:Event):void 
		{
			_loader.removeEventListener( Event.COMPLETE, onPatternFileComplete );
			
			_patternParams = _loader.data;
			
			_loader.removeEventListener( Event.COMPLETE, onPatternFileComplete );
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, onIOErrorEvent );
			_loader = null;
			
			dispatchEvent( new Event( FLARLoaders.PARAMS_LOADED ) );
			_loaded = true;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Lance le chargement
		 */
		public function load():void
		{
			if ( _loaded || _loading ) 
				return;
			
			_loader.load( _request );
			
			dispatchEvent( new Event( FLARLoaders.LOADING ) );
			_loading = true;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/** Renvoie les parametres de la caméra sous forme de ByteArray */
		public function get cameraParams():ByteArray { return _cameraParams; }
		/** Renvoie les parametres du marker sous la forme d'une chaine de caractères */
		public function get patternParams():String { return _patternParams; }
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}