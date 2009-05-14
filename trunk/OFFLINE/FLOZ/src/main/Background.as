
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import fr.minuit4.utils.UImg;
	import gs.easing.Cubic;
	import gs.TweenLite;
	
	public class Background extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const MATRIX:Matrix = new Matrix();
		private const MATRIXROTATION:Matrix = new Matrix();
		private const COLORS:Array = [ 0x5abfb4, 0xa5c265 ];
		private const ALPHAS:Array = [ .75, .75 ];
		private const RATIOS:Array = [ 0, 255 ];
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _backgroundHolder:Bitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Background() 
		{
			_backgroundHolder = new Bitmap( null, PixelSnapping.AUTO, true );
			_backgroundHolder.alpha = 0;
			addChild( _backgroundHolder );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			drawBackground();
			TweenLite.to( _backgroundHolder, .4, { alpha: 1, ease: Cubic.easeIn } );
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		private function onResize(e:Event):void 
		{
			drawBackground();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function drawBackground():void
		{
			var bd:BitmapData = new BitmapData( stage.stageWidth, stage.stageHeight, true, 0x00 );
			bd.draw( UImg.resize( Config.background, stage.stageWidth, stage.stageHeight, false ) );
			
			_backgroundHolder.bitmapData = bd;
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			MATRIXROTATION.createGradientBox( stage.stageWidth, stage.stageHeight, -Math.PI * .5 );
			g.beginGradientFill( GradientType.LINEAR, COLORS, ALPHAS, RATIOS, MATRIXROTATION );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
			bd.draw( s, MATRIX, null, BlendMode.OVERLAY );
			
			s = null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}