
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import fr.floz.isometric.objects.primitives.IsoBox;
	import fr.floz.isometric.objects.primitives.IsoRect;
	import fr.floz.isometric.scenes.IsoGrid;
	
	public class Main6 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main6() 
		{
			var grid:IsoGrid = new IsoGrid( 32, 10, 10 );
			addChild( grid );
			
			var b:IsoBox = new IsoBox( 64, 64, 32 );
			b.x = 64 << 2;
			b.y = 64;
			addChild( b );
			
			trace( "WIDTH : " + b.width );
			trace( "HEIGHT : " + b.height );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}