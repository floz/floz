
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class InfoBar extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _barHolder:Bitmap;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function InfoBar( width:Number, height:Number ) 
		{
			_barHolder = new Bitmap( null, PixelSnapping.AUTO, true );
			addChild( _barHolder );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		private function onResize(e:Event):void 
		{
			drawBar();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function drawBar():void
		{
			var bd:BitmapData = new BitmapData( stage.stageWidth, 20, true );
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginGradientFill( GradientType.LINEAR, [ 0x5dc2b6, 0xa2c268 ], [ 1, 1 ], [ 0, 255 ] );
			g.drawRect( 0, 0, stage.stageWidth, 20 );
			g.endFill();
			
			bd.draw( s );
			s = null;
			
			_barHolder.bitmapData = bd;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}