
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package characters 
{
	import assets.LinkBottom_FC;
	import assets.LinkLeft_FC;
	import assets.LinkTop_FC;
	import com.wtf.engines.renderer.RendererEngine;
	import com.wtf.misc.AnimatedBitmap;
	import com.wtf.misc.MovieBitmap;
	import com.wtf.mobiles.Mobile;
	import com.wtf.mobiles.MobileManager;
	import com.wtf.mobiles.players.Link;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Matrix;
	
	public class MainCharater extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainCharater() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var renderer:RendererEngine = RendererEngine.getInstance();
			renderer.setup( 50 );
			renderer.start();
			
			var mobileManager:MobileManager = MobileManager.getInstance();
			
			var link:Link = new Link();
			mobileManager.register( link );
			addChild( link );
			
			renderer.register( mobileManager );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}