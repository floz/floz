
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.flartoolkit 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Video;
	import flash.utils.ByteArray;
	import fr.minuit4.flartoolkit.detector.FLARDetectorsManager;
	import fr.minuit4.webcam.WebCam;
	import org.libspark.flartoolkit.core.FLARCode;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.core.raster.rgb.FLARRgbRaster_BitmapData;
	import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	
	public class FLARApp extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _webcam:WebCam;
		
		private var _cameraParams:FLARParam;
		private var _detectors:Array;
		
		private var _capture:BitmapData;
		private var _raster:FLARRgbRaster_BitmapData;
		private var _detectorsManager:FLARDetectorsManager;
		
		private var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FLARApp( webcam:WebCam, cameraParams:ByteArray = null ) 
		{
			_webcam = webcam;
			if ( cameraParams )
			{
				_cameraParams = new FLARParam();
				_cameraParams.loadARParam( cameraParams );
			}
			
			_detectors = [];			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onFrame(e:Event):void
		{
			_capture.draw( _webcam );
			_detectorsManager.detectMarkers();
			
			addChild( new Bitmap( _detectorsManager.getBmp() ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			if ( !_webcam.isRunning() )
				_webcam.activate();
			
			_capture = new BitmapData( _webcam.width, _webcam.height, false, 0x00 );			
			_raster = new FLARRgbRaster_BitmapData( _capture );
			
			_detectorsManager = new FLARDetectorsManager( _detectors, _raster );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function attachCameraParams( cameraParams:ByteArray ):void
		{
			if ( _cameraParams )
				throw new Error( "One camera parameter as already been attached." );
			
			_cameraParams = new FLARParam();
			_cameraParams.loadARParam( cameraParams );			
		}
		
		public function attachMarker( markerParams:String ):void
		{
			if ( !_cameraParams )
				throw new Error( "You first have to attach a camera by the attachCameraParams() method." );
				
			var marker:FLARCode = new FLARCode( 16, 16 );
			marker.loadARPatt( markerParams );
			
			var detector:FLARSingleMarkerDetector = new FLARSingleMarkerDetector( _cameraParams, marker, 80 );
			_detectors.push( { detector: detector, trans: new FLARTransMatResult(), detected: false } );
		}
		
		public function activate():void
		{
			if ( !_webcam || !_cameraParams )
				throw new Error( "There is no webcam or camera parameters (.dat file) attach." );
			
			init();
			
			_running = true;
		}
		
		public function destroy():void
		{
			// destroy
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}