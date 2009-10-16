
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.managers 
{
	import elive.core.challenges.Challenge;
	import elive.core.users.User;
	import flash.events.EventDispatcher;
	
	public class EliveManager extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _instance:EliveManager;
		private static var _allowInstanciation:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EliveManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, please use the getInstance method." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():EliveManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new EliveManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}