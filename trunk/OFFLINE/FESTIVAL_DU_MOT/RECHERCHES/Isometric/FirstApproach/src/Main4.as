
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import fr.floz.isometric.display.primitives.IsoRect;
	
	public class Main4 extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main4() 
		{
			var rect:IsoRect = new IsoRect( 0, 50, 25 );
			rect.x = 50;
			rect.y = 50;
			addChild( rect );
			
			rect = new IsoRect( 50, 0, 25 );
			rect.x = 50;
			rect.y = 50;
			addChild( rect );
			
			rect = new IsoRect( 50, 50, 0 );
			rect.x = 50;
			rect.y = 50;
			addChild( rect );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}