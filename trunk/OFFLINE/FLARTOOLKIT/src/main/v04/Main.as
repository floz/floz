
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
	import fr.minuit4.flartoolkit.loaders.MarkerParamsLoader;
	import fr.minuit4.webcam.WebCam;
	
	public class Main extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _webcam:WebCam;
		private var _flar:FLARApp;
		
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
			_flar = new FLARApp( _webcam, BasicFLARLoaders( e.currentTarget ).cameraParams );
			_flar.attachMarker( BasicFLARLoaders( e.currentTarget ).getMarkersParams() );
			
			var markerLoader:MarkerParamsLoader = new MarkerParamsLoader();
			markerLoader.addEventListener( MarkerParamsLoader.MARKER_PARAMS_LOAD, onMarkerParamsLoad );
			markerLoader.load( "rectanglecarre.dat" );
		}
		
		private function onMarkerParamsLoad(e:Event):void 
		{
			_flar.attachMarker( MarkerParamsLoader( e.currentTarget ).getMarkerParams() );
			_flar.activate();
			addChild( _flar );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}