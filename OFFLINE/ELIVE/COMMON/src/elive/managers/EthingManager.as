
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.managers 
{
	
	public class EthingManager 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _instance:EthingManager;
		private static var _allowInstanciation:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EthingManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, please use the getInstance method." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():EthingManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new EthingManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}