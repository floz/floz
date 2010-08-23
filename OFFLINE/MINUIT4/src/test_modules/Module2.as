
/**
 * @author Floz
 */
package test_modules 
{
	import aze.motion.eaze;
	import fr.minuit4.core.navigation.modules.Module;

	public class Module2 extends Module
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Module2() 
		{
			trace( "Module2: new" );
			
			graphics.beginFill( 0x00ffff );
			graphics.drawRect( 0, 0, 300, 120 );
			
			alpha = 0;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function show(delay:Number = 0):Number 
		{
			trace( "Module2: show" );
			eaze( this ).to( .5, { alpha: 1 } );
			return .5;
		}
		
		override public function hide(delay:Number = 0):Number 
		{
			trace( "Module2: hide" );
			eaze( this ).to( .5, { alpha: 0 } );
			return .5;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}