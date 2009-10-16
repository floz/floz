
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import elive.events.NavEvent;
	import elive.navigation.NavContainer;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import flash.display.Sprite;
	import flash.events.Event;
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
			_navManager.addEventListener( NavEvent.SWITCH_RUBRIQUE, switchRubriqueHandler, false, 0, true );
			
			Config.addEventListener( Event.COMPLETE, configCompleteHandler );
			Config.load( "xmls/conf.xml", new DynamicXML() );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function configCompleteHandler(e:Event):void 
		{
			createNav();
			createEthing();
			createElivePanel();
		}
		
		private function switchRubriqueHandler(e:NavEvent):void 
		{
			switch( e.rubId )
			{
				case NavIds.ELIVES: trace( NavIds.ELIVES ); break;
				case NavIds.AMIS: trace( NavIds.AMIS ); break;
				case NavIds.PROFIL: trace( NavIds.PROFIL ); break;
			}
			
			// La rubrique devra etendre d'une classe genre "Rubrique"
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createNav():void
		{
			var navContainer:NavContainer = new NavContainer();
			navContainer.createNav();
			addChild( navContainer );
		}
		
		private function createEthing():void
		{
			
		}
		
		private function createElivePanel():void
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}