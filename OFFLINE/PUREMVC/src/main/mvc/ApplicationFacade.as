
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.mvc 
{
	import main.mvc.controller.StartupCommand;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const STARTUP:String = "startup";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			registerCommand( STARTUP, StartupCommand );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():ApplicationFacade
		{
			if ( !instance ) instance = new Facade();
			return instance as ApplicationFacade;
		}
		
		public function startup( stage:Object ):void
		{
			sendNotification( STARTUP, stage );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}