
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.flartoolkit.detector 
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import org.libspark.flartoolkit.core.FLARSquareDetector;
	import org.libspark.flartoolkit.core.FLARSquareStack;
	import org.libspark.flartoolkit.core.match.FLARMatchPatt_Color_WITHOUT_PCA;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.core.raster.FLARRaster_BitmapData;
	import org.libspark.flartoolkit.core.raster.rgb.FLARRgbRaster_BitmapData;
	import org.libspark.flartoolkit.core.types.FLARIntSize;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	
	public class FLARDetectorsManager extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _detectors:Array; // { detector, trans, detected }
		private var _raster:FLARRgbRaster_BitmapData;
		private var _detectorsDict:Dictionary;
		
		private var _squareList:FLARSquareStack;
		private var _squareDetect:FLARSquareDetector;	
		
		private var _resultsDetectors:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FLARDetectorsManager( detectors:Array, raster:FLARRgbRaster_BitmapData ) 
		{
			_detectors = detectors;
			_raster = raster;
			
			_detectorsDict = new Dictionary();
			var n:int = _detectors.length;
			for ( var i:int; i < n; i++ )
				_detectorsDict[ _detectors[ i ] ] = i;
			
			_resultsDetectors = [];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getCurrentDetectorIndex( detector:FLARSingleMarkerDetector ):int
		{
			var n:int = _resultsDetectors.length;
			if ( n == 1 ) return 0;
			
			for ( var i:int; i < n; i++ )
				if ( _resultsDetectors[ i ] == detector ) return i;
			
			return -1;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function detectMarkers():void
		{
			var b:Boolean;
			var detected:Boolean;
			var detector:FLARSingleMarkerDetector;
			var n:int = _detectors.length;
			for ( var i:int; i < n; i++ )
			{
				detector = _detectors[ i ].detector;
				detected = _detectors[ i ].detected;
				
				trace( _resultsDetectors.length );
				b = detector.detectMarkerLite( _raster, 80 ) && detector.getConfidence() > .5;
				if ( b && !detected )
				{
					_resultsDetectors.push( detector );
					_detectors[ i ].detected = true;
				}
				else if ( !b && detected )
				{
					_resultsDetectors.splice( getCurrentDetectorIndex( detector ), 1 );
					_detectors[ i ].detected = false;
				}
			}
		}
		
		public function getBmp():BitmapData { return _raster.bitmapData; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}