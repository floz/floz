
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package poolArray 
{
	
	public class ItemArray
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var name:String = "free";
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void
		{
			PoolArrayItem.release( this );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}