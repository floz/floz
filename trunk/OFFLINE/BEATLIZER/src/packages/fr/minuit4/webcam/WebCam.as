
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.webcam 
{
	import flash.media.Camera;
	import flash.media.Video;
	
	public class WebCam extends Video
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _vWidth:Number;
		private var _vHeight:Number;
		private var _fps:Number;
		
		private var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function WebCam( vWidth:Number, vHeight:Number, fps:Number = 30 ) 
		{
			_vWidth = vWidth;
			_vHeight = vHeight;
			_fps = fps;
			
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
			
			camera.setMode( _vWidth, _vHeight, stage ? stage.frameRate : 30, true );
			
			this.attachCamera( camera );
			_running = true;
		}
		
		public function isRunning():Boolean
		{
			return _running;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}