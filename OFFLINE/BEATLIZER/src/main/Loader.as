
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import fr.minuit4.tools.Loading;
	import fr.minuit4.utils.UBit;
	
	public class Loader extends MovieClip
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _bgd:BitmapData;
		private var _loading:Loading;
		private var _imageLoader:ImageLoader;
		private var _bg:Bitmap;
		
		private var _app:MovieClip;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:MovieClip;
		public var cntApp:MovieClip;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Loader() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_bgd = UBit.strech( new Motif( 0, 0 ), stage.stageWidth, stage.stageHeight );
			_bg = new Bitmap( _bgd );
			cnt.addChild( _bg );
			
			_loading = new Loading();
			_loading.x = 980 * .5 - _loading.width * .5;
			_loading.y = 560 * .5 - _loading.height * .5;
			cnt.addChild( _loading );
			_loading.play();
			
			_imageLoader = new ImageLoader();
			_imageLoader.addEventListener( Event.COMPLETE, onComplete );
			_imageLoader.load( "main.swf" );
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onComplete(e:Event):void 
		{
			_app = _imageLoader.getItemLoaded();
			cntApp.addChild( _app );
			
			_loading.stop();
			cnt.removeChild( _loading );
			
			_imageLoader.destroy();
		}
		
		private function onResize(e:Event):void 
		{
			_bgd = UBit.strech( new Motif( 0, 0 ), stage.stageWidth, stage.stageHeight );
			_bg.bitmapData = _bgd;
			cnt.x = cnt.y = 0;
			
			cntApp.x = stage.stageWidth * .5 - 980 * .5;
			cntApp.y = stage.stageHeight * .5 - 560 * .5;
			
			if ( _loading.parent && _loading.playing )
			{
				_loading.x = stage.stageWidth * .5 - _loading.width * .5;
				_loading.y = stage.stageHeight * .5 - _loading.height * .5;
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}