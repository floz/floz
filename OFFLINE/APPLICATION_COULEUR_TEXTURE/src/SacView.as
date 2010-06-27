
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import assets.sacs.AssetSac1ChangeColor;
	import aze.motion.eaze;
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import sacs.AssetSac1;
	
	public class SacView extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sac:AssetSac1;
		private var _colorBag:AssetSac1ChangeColor;
		private var _part:Bitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SacView() 
		{
			initSac();
			initPart();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initSac():void
		{
			_sac = new AssetSac1();
			addChild( _sac );
			
			_colorBag = new AssetSac1ChangeColor();
			_colorBag.blendMode = BlendMode.OVERLAY;
			addChild( _colorBag );
		}
		
		private function initPart():void
		{
			//_part = new 
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function changeColor( color:uint ):void
		{
			//eaze( _sac ).to( .25 ).tint( color, .5, .5 );
			eaze( _colorBag ).to( .25 ).colorMatrix( 0, 0, 0, 0, color, 1 );//tint( color, .5, .5 );
			
			//eaze( _colorBag ).to( .25 ).tint( color );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}