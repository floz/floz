
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	
	public class NavigationManager
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:NavigationManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavigationManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use getInstance method instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():NavigationManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new NavigationManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}