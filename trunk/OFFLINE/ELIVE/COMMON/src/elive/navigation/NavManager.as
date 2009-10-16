
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	import elive.events.NavEvent;
	import flash.events.EventDispatcher;
	
	public class NavManager extends EventDispatcher
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:NavManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use getInstance methode instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():NavManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new NavManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public function switchRub( rubId:String, sectionId:int = 0, id:int = -1 ):void
		{
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_RUBRIQUE );
			navEvent.rubId = rubId;
			navEvent.sectionId = sectionId;
			navEvent.id = id;
			dispatchEvent( navEvent );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}