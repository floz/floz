
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.rubriques 
{
	import flash.display.Sprite;
	import fr.minuit4.core.configuration.Configuration;
	
	public class Rubrique extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Rubrique() 
		{
			if ( !stage )
			{
				Configuration.baseURL = "../../";
			}
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}