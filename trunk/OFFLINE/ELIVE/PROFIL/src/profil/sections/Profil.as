
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package profil.sections 
{
	import assets.GBtRetour;
	import aze.motion.Eaze;
	import elive.core.users.User;
	import elive.events.NavEvent;
	import elive.rubriques.sections.Section;
	import elive.ui.sousmenu.SousMenu;
	import elive.utils.EliveUtils;
	import elive.xmls.EliveXML;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.net.loaders.types.DatasLoader;
	import profil.sections.sheets.Sheet;
	import profil.sections.sheets.SheetGalerie;
	import profil.sections.sheets.SheetInfos;
	
	public class Profil extends Section
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ongletTitle:GOngletSolo;
		private var _cntSheet:Sprite;
		private var _sheet:Sheet;
		private var _sousMenu:SousMenu;
		
		private var _datasLoader:DatasLoader;
		private var _xml:XML;
		private var _user:User;
		
		private var _currentSousRub:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 0;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Profil() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
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
			_ongletTitle = new GOngletSolo();
			_ongletTitle.x = 3;
			addChild( _ongletTitle );
			
			buildSousMenu();
			
			_cntSheet = new Sprite();
			_cntSheet.x = 5;
			_cntSheet.y = 85;
			addChild( _cntSheet );
			
			_datasLoader = new DatasLoader( Configuration.pathXML + "/user_settings.xml" );
			_datasLoader.addEventListener( Event.COMPLETE, xmlLoadHandler, false, 0, true );
			_datasLoader.load();
		}
		
		private function buildSousMenu():void
		{
			_sousMenu = new SousMenu();
			_sousMenu.addItem( "Infos", SousRubIds.INFOS, "elives_sousmenu_bt_over_default" );
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
			_activated = true;
		}
		
		override public function deactivate():void 
		{
			if ( !_activated ) return;
			_activated = false;
		}
		
		override public function dispose():void
		{
			Eaze.killTweensOf( _sheet );
			
			_ongletTitle = null;
			
			_cntSheet = null;
			
			deactivate();
		}		
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}