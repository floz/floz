
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.about 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.animation.Loading;
	import fr.minuit4.net.loaders.types.MovieLoader;
	import fr.minuit4.utils.UImg;
	import gs.easing.Cubic;
	import gs.TweenLite;
	import main.Config;
	
	public class AboutPhoto extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loading:Loading;
		private var _movieLoader:MovieLoader;
		
		private var _photoHolder:Bitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var strk:Sprite;
		public var cnt:Sprite;
		public var shadow:Sprite;
		public var cntLoading:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AboutPhoto() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			if ( _photoHolder )
			{
				_photoHolder.bitmapData.dispose();
				_photoHolder = null;
			}
			
			if ( _loading ) killLoading();
			
			TweenLite.killTweensOf( shadow );
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			strk.filters = [ Config.glowFilter ];
			
			_loading = new Loading();
			cntLoading.addChild( _loading );
			_loading.x = strk.width * .5 - _loading.width * .5 + 15;
			_loading.y = strk.height * .5 - _loading.height * .5 + 15;
			_loading.play();	
			
			_movieLoader = new MovieLoader();
			_movieLoader.addEventListener( Event.COMPLETE, onLoadComplete );
			_movieLoader.load( Config.path_img + "photo.jpg" );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			_movieLoader.removeEventListener( Event.COMPLETE, onLoadComplete );
			
			TweenLite.to( _loading, .3, { alpha: 0, ease: Cubic.easeOut, onComplete: killLoading } );
			
			var b:BitmapData = UImg.resize( Bitmap( _movieLoader.getItemLoaded() ).bitmapData.clone(), strk.width, strk.height );
			_photoHolder = new Bitmap( b, PixelSnapping.AUTO, true );
			cnt.addChild( _photoHolder );
			
			TweenLite.to( shadow, .3, { alpha: 0, ease: Cubic.easeOut } );
			
			_movieLoader.destroy();
			_movieLoader = null;			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function killLoading():void
		{
			TweenLite.killTweensOf( _loading );
			
			_loading.stop();
			cntLoading.removeChild( _loading );
			_loading = null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}