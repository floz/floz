
/**
 * @author Floz
 */
package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _canvas:Canvas;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_canvas = new Canvas( stage.stageWidth, stage.stageHeight, 0xcccccc );
			addChild( _canvas );
			
			var brush:Brush = new Brush();
			_canvas.addBrush( brush );
			
			stage.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
			_canvas.startCapture();
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
			_canvas.stopCapture();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}