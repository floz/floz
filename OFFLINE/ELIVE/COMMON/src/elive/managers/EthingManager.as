
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.managers 
{
	import elive.events.EthingEvent;
	import flash.events.EventDispatcher;
	
	public class EthingManager extends EventDispatcher
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
		
		public function ethingIsOk():void
		{
			var ethingEvent:EthingEvent = new EthingEvent( EthingEvent.ANIM_REQUEST );
			ethingEvent.label = "ok";
			dispatchEvent( ethingEvent );
		}
		
		public function ethingAcclame():void
		{
			var ethingEvent:EthingEvent = new EthingEvent( EthingEvent.ANIM_REQUEST );
			ethingEvent.label = "cparti";
			dispatchEvent( ethingEvent );
		}
		
		public function ethingJump():void
		{
			var ethingEvent:EthingEvent = new EthingEvent( EthingEvent.ANIM_REQUEST );
			ethingEvent.label = "saute";
			dispatchEvent( ethingEvent );
		}
		
		public function ethingSendElive():void
		{
			var ethingEvent:EthingEvent = new EthingEvent( EthingEvent.ANIM_REQUEST );
			ethingEvent.label = "envoielive";
			dispatchEvent( ethingEvent );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}