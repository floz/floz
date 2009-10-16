
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import elive.events.EliveEvent;
	import elive.events.NavEvent;
	import elive.navigation.NavManager;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.core.datas.dynamics.DynamicXML;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _navManager:NavManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			Configuration.DEBUG = true;
			
			_navManager = NavManager.getInstance();
			_navManager.addEventListener( NavEvent.RUBRIQUE_CHANGE, rubriqueChangeHandler, false, 0, true );
			
			Config.addEventListener( Event.COMPLETE, configCompleteHandler );
			Config.load( "xmls/conf.xml", new DynamicXML() );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function configCompleteHandler(e:Event):void 
		{
			_navManager.parseNav( XML( Config.getProperty( "nav" ) ) );
			createNav();
		}
		
		private function rubriqueChangeHandler(e:NavEvent):void 
		{
			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createNav():void
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}