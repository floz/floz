
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main.v04 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import fr.minuit4.flartoolkit.FLARApp;
	import fr.minuit4.flartoolkit.loaders.BasicFLARLoaders;
	import fr.minuit4.webcam.WebCam;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _webcam:WebCam;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_webcam = new WebCam( stage.stageWidth, stage.stageHeight );
			
			var loader:BasicFLARLoaders = new BasicFLARLoaders( "camera_para.dat", "floz1.pat" );
			loader.addEventListener( BasicFLARLoaders.PARAMS_LOADED, onParamsLoaded );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onParamsLoaded(e:Event):void 
		{
			var flar:FLARApp = new FLARApp( _webcam, BasicFLARLoaders( e.currentTarget ).cameraParams );
			flar.attachMarker( BasicFLARLoaders( e.currentTarget ).patternParams );
			flar.activate();
			addChild( flar );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}