
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class ColorSquare extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var color:uint;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ColorSquare( color:uint ) 
		{
			this.color = color;
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var g:Graphics = this.graphics;
			g.lineStyle( 0, 0x000000 );
			g.beginFill( color );
			g.drawRect( 0, 0, 20, 20 );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}