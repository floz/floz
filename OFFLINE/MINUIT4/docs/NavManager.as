
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package core.nav 
{
	import flash.events.EventDispatcher;
	
	public class NavManager extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _currentId:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var frozen:Boolean;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavManager() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function freeze():void { frozen = true; }
		
		public function unfreeze():void { frozen = false; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get currentId():String { return _currentId; }
		
		public function set currentId(value:String):void 
		{
			if ( frozen || _currentId == value )
				return;
			
			_currentId = value;
			dispatchEvent( new NavEvent( NavEvent.NAV_CHANGE ) );
		}
		
	}
	
}