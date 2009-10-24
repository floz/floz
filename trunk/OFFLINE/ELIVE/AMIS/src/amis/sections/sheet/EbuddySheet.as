
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet 
{
	import amis.sections.sheet.sheets.Sheet;
	import amis.sections.sheet.sheets.SheetElives;
	import amis.sections.sheet.sheets.SheetGalerie;
	import amis.sections.sheet.sheets.SheetInfos;
	import assets.GBtRetour;
	import aze.motion.Eaze;
	import elive.core.users.User;
	import elive.events.NavEvent;
	import elive.navigation.HistoricManager;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import elive.rubriques.sections.Section;
	import elive.ui.sousmenu.SousMenu;
	import elive.utils.EliveUtils;
	import elive.xmls.EliveXML;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.net.loaders.types.DatasLoader;
	
	public class EbuddySheet extends Section
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _historicManager:HistoricManager;
		private var _navManager:NavManager;
		private var _ongletTitle:GOngletSolo;
		private var _backButton:GBtRetour;
		private var _cntSheet:Sprite;
		private var _sheet:Sheet;
		private var _sousMenu:SousMenu;
		
		private var _datasLoader:DatasLoader;
		private var _xml:XML;
		private var _user:User;
		
		private var _currentSousRub:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 1;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EbuddySheet() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function backButtonDownHandler(e:MouseEvent):void 
		{
			if ( _historicManager.getLastNavId() == NavIds.AMIS )
			{
				var navEvent:NavEvent;
				navEvent = new NavEvent( NavEvent.SWITCH_SECTION, true );
				navEvent.sectionId = 0;
				dispatchEvent( navEvent );
			}
			else
			{
				_navManager.switchRub( _historicManager.getLastNavId(), _historicManager.getLastSectionId() );
			}			
		}
		
		private function xmlLoadHandler(e:Event):void 
		{
			_xml = XML( _datasLoader.getItemLoaded() );
			
			_datasLoader.removeEventListener( Event.COMPLETE, xmlLoadHandler );
			_datasLoader.dispose();
			_datasLoader = null;
			
			_user = EliveXML.parseUser( _xml.user[ 0 ] );
			EliveUtils.configureText( _ongletTitle.tf, "elives_menu_bt", _user.name.toUpperCase() );
			
			_currentSousRub = SousRubIds.INFOS;
			onSwitchSousRub();
		}
		
		private function switchSousRubriqueHandler(e:NavEvent):void 
		{
			e.stopImmediatePropagation();
			
			if ( _currentSousRub == e.navId )
				return;
			
			_currentSousRub = e.navId;
			onSwitchSousRub();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_historicManager = HistoricManager.getInstance();
			_navManager = NavManager.getInstance();
			
			_ongletTitle = new GOngletSolo();
			_ongletTitle.x = 3;
			addChild( _ongletTitle );
			
			_backButton = new GBtRetour();
			_backButton.y = 30;
			_backButton.buttonMode = true;
			addChild( _backButton );
			
			buildSousMenu();
			
			_cntSheet = new Sprite();
			_cntSheet.x = 10;
			_cntSheet.y = 85;
			addChild( _cntSheet );
		}
		
		private function buildSousMenu():void
		{
			_sousMenu = new SousMenu();
			_sousMenu.addItem( "Infos", SousRubIds.INFOS, "elives_sousmenu_bt_over_default" );
			_sousMenu.addItem( "(e)lives", SousRubIds.ELIVES, "elives_sousmenu_bt_over_default" );
			_sousMenu.addItem( "Galerie", SousRubIds.GALERIE, "elives_sousmenu_bt_over_default" );
			_sousMenu.buildSeparatorBars();
			_sousMenu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubriqueHandler, false, 0, true );
			_sousMenu.x = int( 288 * .5 - _sousMenu.width * .5 );
			_sousMenu.y = 50;
			addChild( _sousMenu );
		}
		
		private function onSwitchSousRub():void
		{
			while ( _cntSheet.numChildren ) _cntSheet.removeChildAt( 0 );
			_sheet = null;
			
			if ( _currentSousRub == SousRubIds.INFOS )
				_sheet = new SheetInfos();
			else if ( _currentSousRub == SousRubIds.ELIVES )
				_sheet = new SheetElives();
			else if ( _currentSousRub == SousRubIds.GALERIE )
				_sheet = new SheetGalerie();
			
			_sheet.linkTo( _user );
			
			Eaze.from( _sheet, .25, { alpha: .4 } );
			_cntSheet.addChild( _sheet );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function activate():void 
		{
			if ( _activated ) return;
			_backButton.addEventListener( MouseEvent.MOUSE_DOWN, backButtonDownHandler, false, 0, true );
			_activated = true;
		}
		
		override public function deactivate():void 
		{
			if ( !_activated ) return;
			_backButton.removeEventListener( MouseEvent.MOUSE_DOWN, backButtonDownHandler );
			_activated = false;
		}
		
		override public function linkTo(id:int):void 
		{
			_datasLoader = new DatasLoader( Configuration.pathXML + "/user_settings.xml" );
			_datasLoader.addEventListener( Event.COMPLETE, xmlLoadHandler, false, 0, true );
			_datasLoader.load();
		}
		
		override public function dispose():void
		{
			Eaze.killTweensOf( _sheet );
			
			_historicManager = null;
			_navManager = null;
			
			_ongletTitle = null;
			
			_cntSheet = null;
			
			deactivate();
			_backButton = null;
		}		
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}