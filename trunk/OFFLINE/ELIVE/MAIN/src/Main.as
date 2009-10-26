
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import assets.fonts.FAkkurat;
	import assets.fonts.FAkkuratBold;
	import assets.GLogo;
	import aze.motion.Eaze;
	import elive.managers.EthingManager;
	import elive.managers.SoutenanceManager;
	import elive.utils.EliveUtils;
	import flash.display.BlendMode;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
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
		private var _ethingManager:EthingManager;
		private var _globalContainer:Sprite;
		private var _cntPanel:Sprite;
		
		private var _ething:Sprite;
		private var _navContainer:NavContainer;
		
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
			
			_ethingManager = EthingManager.getInstance();
			
			_globalContainer = new Sprite();
			_globalContainer.y = 15;
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
			
			var sound:Sound = new Sound( new URLRequest( "mp3/startup.mp3" ) );
			sound.play();
			
			if ( !Configuration.DEBUG )
			{
				var logo:GLogo = new GLogo();
				logo.x = 200 - 30;
				logo.y = 525;
				_globalContainer.addChild( logo );
				logo.gotoAndPlay( 1 );
				Eaze.delay( 2 ).chainTo( logo, .5, { alpha: 0 } ).onComplete( createEthing );
			}
			else createEthing();
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{			
			if ( e.charCode == 249 )
				SoutenanceManager.incrementActionSheet();
		}
		
		private function switchRubriqueHandler(e:NavEvent):void 
		{
			switch( e.navId )
			{
				case NavIds.ELIVES:
				case NavIds.AMIS:
				case NavIds.PROFIL:
				case NavIds.EMAKE:
					_elivePanel.loadRub( e.navId, e.sectionId, e.id );
					if( !_elivePanel.parent ) _cntPanel.addChild( _elivePanel );
					break;
				
				default:
					_cntPanel.removeChild( _elivePanel );
					break;
			}
			
			//if ( e.navId == NavIds.HOME ) return;			
			//
			//if ( e.navId == NavIds.ELIVES ) 
				//_ethingManager.ethingAcclame();
			//else
				//_ethingManager.ethingIsOk();
		}
		
		private function ethingLoadedHandler(e:Event):void 
		{
			var assetsLoader:AssetsLoader = e.currentTarget as AssetsLoader;
			assetsLoader.removeEventListener( Event.COMPLETE, ethingLoadedHandler );
			
			_ething = assetsLoader.getItemLoaded();
			_ething.x = 200 - 30;
			_ething.y = 510;
			_ething.addEventListener( MouseEvent.MOUSE_DOWN, ethingDownHandler );
			_ething.buttonMode = true;
			_globalContainer.addChild( _ething );
			
			assetsLoader.dispose();
			
			//initWidget();
			
			if ( Configuration.DEBUG )
			{
				addChild( new FPS() );
				
				_globalContainer.x = int( stage.stageWidth * .5 - 219.75 );
				_globalContainer.y = int( 400 - 368.45 );
			}
			
			_ethingManager.ethingJump();
			Eaze.from( _ething, 1, { y: 600, alpha: 0 } ).onComplete( initWidget );
		}
		
		private function ethingDownHandler(e:MouseEvent):void 
		{
			_ething.addEventListener( MouseEvent.MOUSE_UP, ethingUpHandler );
			
			stage.nativeWindow.startMove();
			Mouse.cursor = MouseCursor.HAND;
		}
		
		private function ethingUpHandler(e:MouseEvent):void 
		{
			_ething.removeEventListener( MouseEvent.MOUSE_UP, ethingUpHandler );
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createEthing():void
		{
			while ( _globalContainer.numChildren ) _globalContainer.removeChildAt( 0 );
			
			var assetsLoader:AssetsLoader = new AssetsLoader( Config.getProperty( "pathSWF" ) + "/ething.swf" );
			assetsLoader.addEventListener( Event.COMPLETE, ethingLoadedHandler, false, 0, true );
			assetsLoader.load();
		}
		
		private function initWidget():void
		{
			createElivePanel();
			createNav();
		}
		
		private function createNav():void
		{
			_navContainer = new NavContainer();
			_navContainer.createNav();
			_navContainer.x = int( _ething.x + _ething.width + 60 );
			_navContainer.y = int( 480 );
			_globalContainer.addChild( _navContainer );
		}
		
		private function createElivePanel():void
		{
			_cntPanel = new Sprite();
			_elivePanel = new ElivePanel();
			_globalContainer.addChild( _cntPanel );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}