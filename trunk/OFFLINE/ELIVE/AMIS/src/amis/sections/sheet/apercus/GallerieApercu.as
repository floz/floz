
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.apercus
{
	import assets.GGallerieApercu;
	import elive.utils.EliveUtils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import fr.minuit4.net.loaders.types.AssetsLoader;
	import fr.minuit4.utils.UImg;
	
	public class GallerieApercu extends GGallerieApercu
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _assetsLoader:AssetsLoader;
		private var _imageHolder:Bitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GallerieApercu() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			if ( _assetsLoader && _assetsLoader.hasEventListener( Event.COMPLETE ) )
			{
				_assetsLoader.removeEventListener( Event.COMPLETE, loadCompleteHandler );
				_assetsLoader.dispose();
				_assetsLoader = null;
			}
			
			if ( _imageHolder )
			{
				_imageHolder.bitmapData.dispose();
				_imageHolder.bitmapData = null;
				_imageHolder = null;
			}
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		private function loadCompleteHandler(e:Event):void 
		{
			var imgLoaded:BitmapData = Bitmap( _assetsLoader.getItemLoaded() ).bitmapData;
			_assetsLoader.removeEventListener( Event.COMPLETE, loadCompleteHandler );
			_assetsLoader.dispose();
			_assetsLoader = null;
			
			_imageHolder = new Bitmap( UImg.resize( imgLoaded, apercuBg.cntImage.width, apercuBg.cntImage.height ), PixelSnapping.AUTO, true );
			Sprite( apercuBg.cntImage.cnt ).addChild( _imageHolder );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{	
			apercuTop.bg.transform.colorTransform = EliveUtils.getColorTransform( 0xA10D59 );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setTitleText( text:String ):void
		{
			EliveUtils.configureText( apercuTop.tf, "elives_list_apercu_title", text );
		}
		
		public function loadImage( url:String ):void
		{
			_assetsLoader = new AssetsLoader( url );
			_assetsLoader.addEventListener( Event.COMPLETE, loadCompleteHandler, false, 0, true );
			_assetsLoader.load();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}