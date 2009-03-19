
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.flartoolkit 
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import org.libspark.flartoolkit.core.param.FLARParam;
	
	public class FLARApp extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _vWidth:Number;
		private var _vHeight:Number;
		
		private var _flarParam:FLARParam;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FLARApp( vWidth:Number, vHeight:Number ) 
		{
			_vWidth = vWidth;
			_vHeight = vHeight;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function attachCameraParams( cameraParams:ByteArray ):void
		{
			if ( _flarParam )
				throw new Error( "One camera parameter as already been attached." );
			
			_flarParam = new FLARParam();
			_flarParam.loadARParam( cameraParams );			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}