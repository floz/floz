
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main.v04
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import org.libspark.flartoolkit.core.FLARCode;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.core.raster.rgb.FLARRgbRaster_BitmapData;
	import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	import org.libspark.flartoolkit.pv3d.FLARBaseNode;
	import org.libspark.flartoolkit.pv3d.FLARCamera3D;
	import org.papervision3d.render.LazyRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	public class FLARBase extends MovieClip
	{
		// - CONST -----------------------------------------------------------------------
		
		private const VIDEO_WIDTH:Number = 640;
		private const VIDEO_HEIGHT:Number = 480;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _cnt:Sprite;
		
		private var _cameraParams:FLARParam;
		private var _patternParams:FLARCode;
		private var _video:Video;
		private var _capture:Bitmap;
		private var _raster:FLARRgbRaster_BitmapData;
		private var _detector:FLARSingleMarkerDetector;
		private var _trans:FLARTransMatResult;
		
		private var _renderer:LazyRenderEngine;
		protected var _cnt3D:FLARBaseNode;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FLARBase( ) 
		{
			_cnt = addChild( new Sprite() ) as Sprite;
			
			var flarLoaders:FLARLoaders = new FLARLoaders( "camera_para.dat", "floz1.pat" );
			flarLoaders.addEventListener( FLARLoaders.PARAMS_LOADED, onParamsLoaded );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onParamsLoaded( e:Event ):void
		{
			_cameraParams = new FLARParam();
			_cameraParams.loadARParam( FLARLoaders( e.currentTarget ).cameraParams );
			
			_patternParams = new FLARCode( 16, 16 );
			_patternParams.loadARPatt( FLARLoaders( e.currentTarget ).patternParams );
			
			var camera:Camera = Camera.getCamera();
			if ( !camera )
				throw new Error( "Aucune webcam n'a été détectée." );
			
			camera.setMode( VIDEO_WIDTH, VIDEO_HEIGHT, 30 );			
			
			_video = new Video( VIDEO_WIDTH, VIDEO_HEIGHT );
			_video.attachCamera( camera );
			
			_capture = new Bitmap( new BitmapData( VIDEO_WIDTH, VIDEO_HEIGHT, false, 0x00 ), PixelSnapping.AUTO, true );
			_cnt.addChild( _capture );
			
			_raster = new FLARRgbRaster_BitmapData( _capture.bitmapData );
			_detector = new FLARSingleMarkerDetector( _cameraParams, _patternParams, 80 );
			
			_trans = new FLARTransMatResult();
			
			initPV3D();
			initObject();
		}
		
		private function onFrame(e:Event):void 
		{
			_capture.bitmapData.draw( _video );
			
			if ( _detector.detectMarkerLite( _raster, 80 ) && _detector.getConfidence() > .5 )
			{
				_detector.getTransformMatrix( _trans );
				_cnt3D.setTransformMatrix( _trans );
				_cnt3D.visible = true;
				_renderer.render();
			}
			else
			{
				_cnt3D.visible = false;
				_renderer.render();
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initPV3D():void
		{
			var camera:FLARCamera3D = new FLARCamera3D( _cameraParams );
			var scene:Scene3D = new Scene3D();
			
			var viewPort:Viewport3D = new Viewport3D( VIDEO_WIDTH, VIDEO_HEIGHT );
			viewPort.x = -4;
			_cnt.addChild( viewPort );
			
			_renderer = new LazyRenderEngine( scene, camera, viewPort );
			
			_cnt3D = new FLARBaseNode();
			scene.addChild( _cnt3D );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		protected function initObject():void
		{
			// override content
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setMirrorMode( value:Boolean ):void
		{
			if ( value )
			{
				_cnt.scaleX = -1;
				_cnt.x = VIDEO_WIDTH;
			}
			else
			{
				_cnt.scaleX = 1;
				_cnt.x = 0;
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}