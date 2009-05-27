
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import painting.brushes.Line;
	import painting.brushes.MultiLines;
	import painting.brushes.MultiRibbons;
	import painting.brushes.Ribbon;
	import painting.Canvas;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var canvas:Canvas;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			canvas = new Canvas( stage.stageWidth, stage.stageHeight );
			addChild( canvas );
			
			//canvas.addBrush( new MultiLines( 15, 0, .01 ) );
			canvas.addBrush( new MultiRibbons( 4, 0, .01 ) );
			//canvas.addBrush( new Ribbon( 0x000000, true ) );
			
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onDown(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
			canvas.startPainting();
		}
		
		private function onUp(e:MouseEvent):void 
		{
			canvas.stopPainting();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}