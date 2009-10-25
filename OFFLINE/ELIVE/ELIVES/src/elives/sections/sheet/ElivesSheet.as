/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.sheet 
{
	import assets.GBtRetour;
	import aze.motion.Eaze;
	import elive.core.challenges.Challenge;
	import elive.core.interfaces.ILinkable;
	import elive.events.NavEvent;
	import elive.navigation.HistoricManager;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import elive.rubriques.sections.Section;
	import elive.utils.EliveUtils;
	import elive.xmls.EliveXML;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.core.configuration.Config;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.core.interfaces.IDisposable;
	import fr.minuit4.net.loaders.types.AssetsLoader;
	import fr.minuit4.net.loaders.types.DatasLoader;
	
	public class ElivesSheet extends Section implements ILinkable, IDisposable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _historicManager:HistoricManager;
		private var _navManager:NavManager;
		private var _ongletTitle:GOngletSolo;
		private var _backButton:GBtRetour;
		private var _cntSheet:Sprite;
		private var _sheet:Sheet;
		
		private var _datasLoader:DatasLoader;
		private var _xml:XML;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 1;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ElivesSheet() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function backButtonDownHandler(e:MouseEvent):void 
		{
			if ( _historicManager.getLastNavId() == NavIds.ELIVES )
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
			
			while ( _cntSheet.numChildren ) _cntSheet.removeChildAt( 0 );
			_sheet = new Sheet();
			
			var challenge:Challenge = EliveXML.parseChallenge( _xml );
			EliveUtils.configureText( _ongletTitle.tf, "elives_menu_bt", challenge.title.toUpperCase() );
			_sheet.linkTo( challenge );
			
			Eaze.from( _sheet, .25, { alpha: .4 } );
			_cntSheet.addChild( _sheet );
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
			
			_cntSheet = new Sprite();
			addChild( _cntSheet );
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
		
		override public function linkTo( id:int ):void // TODO: PHP
		{
			_datasLoader = new DatasLoader( Configuration.pathXML + "/action_sheet.xml" );
			_datasLoader.addEventListener( Event.COMPLETE, xmlLoadHandler, false, 0, true );
			_datasLoader.load();
		}
		
		override public function dispose():void
		{
			Eaze.killTweensOf( _sheet );
			
			_historicManager = null;
			_navManager = null;
			
			_ongletTitle = null;
			
			if( _sheet ) _sheet.dispose();
			_sheet = null;
			
			_cntSheet = null;
			
			deactivate();
			_backButton = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}