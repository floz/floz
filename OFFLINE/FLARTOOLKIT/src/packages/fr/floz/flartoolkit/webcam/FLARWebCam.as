
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.flartoolkit.webcam 
{
	import flash.media.Camera;
	import flash.media.Video;
	
	public class FLARWebCam extends Video
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _vWidth:Number;
		private var _vHeight:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FLARWebCam( vWidth:Number, vHeight:Number ) 
		{
			_vWidth = vWidth;
			_vHeight = vHeight;
			
			super( vWidth, vHeight );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			var camera:Camera = Camera.getCamera();
			if ( !camera )
				throw new Error( "No camera detected. Please plug one." );
			
			camera.setMode( _vWidth, _vHeight, stage.frameRate ? stage.frameRate : 30, true );
			
			this.attachCamera( camera );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}