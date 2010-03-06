
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.mobiles.players 
{
	import assets.LinkBottom_FC;
	import assets.LinkLeft_FC;
	import assets.LinkRight_FC;
	import assets.LinkTop_FC;
	import com.wtf.misc.AnimatedBitmap;
	import com.wtf.misc.AnimationsEnum;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Link extends PlayerMobile
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Link() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			buildSprite();
		}
		
		private function buildSprite():void
		{
			var linkTop:AnimatedBitmap = new AnimatedBitmap( new LinkTop_FC( 0, 0 ), 24, 24 );
			var linkBottom:AnimatedBitmap = new AnimatedBitmap( new LinkBottom_FC( 0, 0 ), 24, 24 );
			var linkLeft:AnimatedBitmap = new AnimatedBitmap( new LinkLeft_FC( 0, 0 ), 24, 24 );
			var linkRight:AnimatedBitmap = new AnimatedBitmap( new LinkRight_FC( 0, 0 ), 24, 24 );
			
			addAnimatedBitmap( linkTop, AnimationsEnum.TOP, 1 );
			addAnimatedBitmap( linkBottom, AnimationsEnum.BOTTOM, 1 );
			addAnimatedBitmap( linkLeft, AnimationsEnum.LEFT, 1 );
			addAnimatedBitmap( linkRight, AnimationsEnum.RIGHT, 1 );
			setDefaultAnimation( AnimationsEnum.RIGHT );
			
			expositionTime = 4;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function render( renderTimer:Number ):void
		{
			super.render( renderTimer );
			update();			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}