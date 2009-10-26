
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
	
	public class SoutenanceManager extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _instance:SoutenanceManager;
		private static var _allowInstanciation:Boolean;
		
		public static var valueActionSheet:uint;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SoutenanceManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, please use the getInstance method." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():SoutenanceManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new SoutenanceManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public static function incrementActionSheet():void
		{
			++valueActionSheet;
			EthingManager.getInstance().ethingJump();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}