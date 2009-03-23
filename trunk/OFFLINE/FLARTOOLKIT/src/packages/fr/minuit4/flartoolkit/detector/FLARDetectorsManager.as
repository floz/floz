
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
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function detectMarkers():void
		{
			var detected:Boolean;
			var detector:FLARSingleMarkerDetector;
			var n:int = _detectors.length;
			for ( var i:int; i < n; i++ )
			{
				detector = _detectors[ i ].detector;
				detected = _detectors[ i ].detected;
				
			}
		}
		
		public function getBmp():BitmapData { return _raster.bitmapData; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}