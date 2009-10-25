
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package profil.sections.sheets
{
	import elive.core.users.User;
	import flash.display.Sprite;
	import fr.minuit4.core.interfaces.IDisposable;
	
	public class Sheet extends Sprite implements IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _user:User;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Sheet() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkTo( user:User ):void
		{
			this._user = user;
		}
		
		public function dispose():void
		{
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}