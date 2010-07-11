
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package test_dummy 
{
	import flash.display.Sprite;
	import fr.minuit4.display.ui.misc.Dummy;
	
	public class MainTestDummy extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestDummy() 
		{
			var d1:Dummy = new Dummy();
			d1.x = 100;
			d1.y = 100;
			addChild( d1 );
			
			var d2:Dummy = new Dummy( 40, 40 );
			d2.x = 200;
			d2.y = 100;
			addChild( d2 );
			
			var d3:Dummy = new Dummy( 150, 100, 0x00ff00 );
			d3.x = 350;
			d3.y = 100;
			addChild( d3 );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}