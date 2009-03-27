
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import fr.minuit4.tools.Loading;
	import fr.minuit4.utils.UBit;
	
	public class ImageHolder extends MovieClip
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _image:BitmapData;
		private var _loading:Loading;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var strk:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ImageHolder() 
		{
			strk.visible = false;
			_image = new BitmapData( this.width, this.height, true, 0x00 );
			addChild( new Bitmap( _image, PixelSnapping.AUTO, true ) );
			
			_loading = new Loading( 0x000000 );
			_loading.x = this.width * .5 - _loading.width * .5;
			_loading.y = this.height * .5 - _loading.height * .5;
			addChild( _loading );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function performLoading():void
		{
			_image.fillRect( _image.rect, 0x00 );
			
			_loading.play();
		}
		
		public function setImage( bd:BitmapData ):void
		{
			if ( _loading.playing ) _loading.stop();
			
			_image.draw( UBit.resize( bd, this.width, this.height, false ) );			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}