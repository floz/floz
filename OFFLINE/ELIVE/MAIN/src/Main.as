
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
	import elive.ui.ElivePanel;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.core.datas.dynamics.DynamicXML;
	import fr.minuit4.net.loaders.types.AssetsLoader;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _navManager:NavManager;
		private var _globalContainer:Sprite;
		
		private var _ething:Sprite;
		
		private var _elivePanel:ElivePanel;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			Configuration.DEBUG = true;
			
			_navManager = NavManager.getInstance();
			_navManager.addEventListener( NavEvent.SWITCH_RUBRIQUE, switchRubriqueHandler, false, 0, true );
			
			_globalContainer = new Sprite();
			addChild( _globalContainer );
			
			Config.addEventListener( Event.COMPLETE, configCompleteHandler );
			Config.load( "xmls/conf.xml", new DynamicXML() );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function configCompleteHandler(e:Event):void 
		{
			createEthing();
		}
		
		private function switchRubriqueHandler(e:NavEvent):void 
		{
			switch( e.navId )
			{
				case NavIds.ELIVES: trace( NavIds.ELIVES ); break;
				case NavIds.AMIS: trace( NavIds.AMIS ); break;
				case NavIds.PROFIL: trace( NavIds.PROFIL ); break;
				default: trace( "fermeture !" ); break;
			}
			
			// La rubrique devra etendre d'une classe genre "Rubrique"
		}
		
		private function ethingLoadedHandler(e:Event):void 
		{
			var assetsLoader:AssetsLoader = e.currentTarget as AssetsLoader;
			assetsLoader.removeEventListener( Event.COMPLETE, ethingLoadedHandler );
			
			_ething = assetsLoader.getItemLoaded();
			_ething.x = 300 - 50;
			_ething.y = 525 - 50;
			_globalContainer.addChild( _ething );
			
			assetsLoader.dispose();
			
			initWidget();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createEthing():void
		{
			var assetsLoader:AssetsLoader = new AssetsLoader( Config.getProperty( "pathSWF" ) + "/ething.swf" );
			assetsLoader.addEventListener( Event.COMPLETE, ethingLoadedHandler, false, 0, true );
			assetsLoader.load();
		}
		
		private function initWidget():void
		{
			createNav();
			createElivePanel();
			if ( Configuration.DEBUG )
			{
				_globalContainer.x = stage.stageWidth * .5 - _globalContainer.width * .5;
				_globalContainer.y = stage.stageHeight * .5 - _globalContainer.height * .5;
			}
		}
		
		private function createNav():void
		{
			var navContainer:NavContainer = new NavContainer();
			navContainer.createNav();
			navContainer.x = _ething.x + _ething.width * .5 - navContainer.width * .5;
			navContainer.y = _ething.y + _ething.height + 10;
			_globalContainer.addChild( navContainer );
		}
		
		private function createElivePanel():void
		{
			_elivePanel = new ElivePanel();
			_globalContainer.addChild( _elivePanel );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}