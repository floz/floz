
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package team12 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Config extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:Config;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static var FOCUS_IN:String = "config_focus_in";
		public static var FOCUS_OUT:String = "config_focus_out";
		
		public static var STANDALONE:Boolean = false;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Config() 
		{
			if( !_allowInstanciation ) throw new Error( "Bouboup, cay un singleton gars." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():Config
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new Config();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public function activate():void
		{
			dispatchEvent( new Event( Config.FOCUS_IN ) );
		}
		
		public function deactivate():void
		{
			dispatchEvent( new Event( Config.FOCUS_OUT ) );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}