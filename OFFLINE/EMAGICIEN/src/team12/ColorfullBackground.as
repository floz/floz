
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package team12 
{
	import assets.ColorfullBarrier_FC;
	import assets.MaskBarriers_FC;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	
	public class ColorfullBackground extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _background:Bitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ColorfullBackground() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var bgAsset:ColorfullBarrier_FC = new ColorfullBarrier_FC();
			var bd:BitmapData = new BitmapData( bgAsset.width, bgAsset.height, true, 0x00 );
			bd.draw( bgAsset );
			_background = new Bitmap( bd, PixelSnapping.AUTO, true );
			addChild( _background );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}