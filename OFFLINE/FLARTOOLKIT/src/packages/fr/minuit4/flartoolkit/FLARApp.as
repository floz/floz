
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.flartoolkit 
{
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.utils.ByteArray;
	import org.libspark.flartoolkit.core.FLARCode;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	
	public class FLARApp extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _vWidth:Number;
		private var _vHeight:Number;
		private var _webcam:Video;
		private var _trans:FLARTransMatResult;
		
		private var _cameraParams:FLARParam;
		private var _detectors:Array;
		
		private var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FLARApp( vWidth:Number, vHeight:Number, webcam:Video ) 
		{
			_vWidth = vWidth;
			_vHeight = vHeight;
			_webcam = webcam;
			
			_detectors = [];
			_trans = new FLARTransMatResult();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
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
			if ( !_flarParam )
				throw new Error( "You first have to attach a camera by the attachCameraParams() method." );
				
			var marker:FLARCode = new FLARCode( 16, 16 );
			marker.loadARPatt( markerParams );
			
			var detector:FLARSingleMarkerDetector = new FLARSingleMarkerDetector( _cameraParams, marker, 80 );
			_detectors.push( detector );
		}
		
		public function activate():void
		{
			if ( !_webcam || !_cameraParams )
				throw new Error( "There is no webcam or camera parameters (.dat file) attach." );
			
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}