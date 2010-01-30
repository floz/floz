
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.mobiles 
{
	import com.wtf.engines.renderer.ARenderer;
	
	public class MobileManager extends ARenderer
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:MobileManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MobileManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "Instanciation impossible." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():MobileManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new MobileManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}