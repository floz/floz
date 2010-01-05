
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package step01 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	public class Dot extends Shape
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Dot() 
		{
			graphics.beginFill( 0xff00ff );
			graphics.drawCircle( 0, 0, 3 );
			graphics.endFill();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function clone():Dot
		{
			var d:Dot = new Dot();
			d.x = this.x;
			d.y = this.y;
			return d;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}