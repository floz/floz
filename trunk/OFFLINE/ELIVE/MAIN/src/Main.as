
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import assets.fonts.FAkkurat;
	import assets.fonts.FAkkuratBold;
	import elive.utils.EliveUtils;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import fr.minuit4.utils.debug.FPS;
	import ui.panel.ElivePanel;
	import navigation.NavContainer;
	import elive.events.NavEvent;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
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
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Configuration.DEBUG = false;
			
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
			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( Config.getProperty( "css" ) );
			Config.setProperty( "css", styleSheet );
			
			Font.registerFont( FAkkurat );
			Font.registerFont( FAkkuratBold );
			
			createEthing();
		}
		
		private function switchRubriqueHandler(e:NavEvent):void 
		{
			switch( e.navId )
			{
				case NavIds.ELIVES:
				case NavIds.AMIS:
				case NavIds.PROFIL:
					_elivePanel.loadRub( e.navId, e.sectionId, e.id );
					if( !_elivePanel.parent ) _globalContainer.addChild( _elivePanel );
					break;
				
				default:
					_globalContainer.removeChild( _elivePanel );
					break;
			}
		}
		
		private function ethingLoadedHandler(e:Event):void 
		{
			var assetsLoader:AssetsLoader = e.currentTarget as AssetsLoader;
			assetsLoader.removeEventListener( Event.COMPLETE, ethingLoadedHandler );
			
			_ething = assetsLoader.getItemLoaded();
			_ething.x = 200 - 30;
			_ething.y = 525;
			_ething.addEventListener( MouseEvent.MOUSE_DOWN, ethingDownHandler );
			_ething.buttonMode = true;
			_globalContainer.addChild( _ething );
			
			assetsLoader.dispose();
			
			initWidget();
			
			if ( Configuration.DEBUG )
			{
				addChild( new FPS() );
			}
		}
		
		private function ethingDownHandler(e:MouseEvent):void 
		{
			_ething.addEventListener( MouseEvent.MOUSE_UP, ethingUpHandler );
			
			stage.nativeWindow.startMove();
			Mouse.cursor = MouseCursor.HAND;
		}
		
		private function ethingUpHandler(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
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
				_globalContainer.x = int( stage.stageWidth * .5 - 219.75 );
				_globalContainer.y = int( stage.stageHeight * .5 - 368.45 );
			}
		}
		
		private function createNav():void
		{
			var navContainer:NavContainer = new NavContainer();
			navContainer.createNav();
			navContainer.x = _ething.x + _ething.width + 30; //- navContainer.width * .5;
			navContainer.y = _ething.y - 40;
			_globalContainer.addChild( navContainer );
		}
		
		private function createElivePanel():void
		{
			_elivePanel = new ElivePanel();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}