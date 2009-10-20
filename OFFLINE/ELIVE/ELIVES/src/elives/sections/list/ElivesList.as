/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.list 
{
	import assets.GScrollbarBackground;
	import assets.GScrollbarSlider;
	import elive.core.challenges.Challenge;
	import elive.events.NavEvent;
	import elive.rubriques.sections.Section;
	import elive.rubriques.SousRubsIds;
	import elive.xmls.EliveXML;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import fr.minuit4.core.configuration.Configuration;
	import fr.minuit4.net.loaders.types.DatasLoader;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class ElivesList extends Section
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _menu:Menu;
		private var _sousMenu:SousMenu;
		private var _cntApercus:Sprite;
		private var _cntContent:Sprite;
		private var _scrollBar:VScrollbar;
		
		private var _datasLoader:DatasLoader;
		
		private var _challenges:Vector.<Challenge>;
		
		private var _scrolling:Boolean;
		private var _apercuOnScroll:Apercu;
		
		private var _activated:Boolean;
		private var _currentSousRub:String = SousRubsIds.ELIVES_LIST_RECUS;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 0;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ElivesList() 
		{
			init();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			resetChallenges();
			if( _activated )deactivate();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			onSwitchSousRub();
		}
		
		private function datasLoaderCompleteHandler(e:Event):void 
		{
			var xml:XML = XML( _datasLoader.getItemLoaded() );
			
			_datasLoader.removeEventListener( Event.COMPLETE, datasLoaderCompleteHandler );
			_datasLoader.dispose();
			_datasLoader = null;
			
			resetChallenges();
			_challenges = EliveXML.parseChallenges( xml );
			build();
		}
		
		private function switchSousRubHandler(e:NavEvent):void 
		{
			e.stopImmediatePropagation();
			
			_currentSousRub = e.navId;
			onSwitchSousRub();
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			var apercu:Apercu = e.target as Apercu;
			if ( _scrolling )
			{
				_apercuOnScroll = apercu;
				return;
			}
			apercu.over();
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			if ( _scrolling )
			{
				_apercuOnScroll = null;
				return;
			}
			var apercu:Apercu = e.target as Apercu;
			apercu.out();
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			var apercu:Apercu = e.target as Apercu;
			
			var navEvent:NavEvent = new NavEvent( NavEvent.SWITCH_SECTION, true );
			navEvent.sectionId = 1;
			navEvent.id = apercu.getId();
			dispatchEvent( navEvent );
		}
		
		private function dragStartHandler(e:Event):void 
		{
			_scrolling = true;
		}
		
		private function dragStopHandler(e:Event):void 
		{
			_scrolling = false;
			if ( _apercuOnScroll ) _apercuOnScroll.over();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_menu = new Menu();
			_menu.x = 3;
			addChild( _menu );
			
			_sousMenu = new SousMenu();
			_sousMenu.y = 53;
			addChild( _sousMenu );
			
			_cntContent = new Sprite();
			_cntContent.x = 5;
			_cntContent.y = 90;
			addChild( _cntContent );
			
			buildContent();
		}
		
		private function buildContent():void
		{
			_cntApercus = new Sprite();
			_cntApercus.y = 5;
			_cntContent.addChild( _cntApercus );
			
			var mask:Sprite = new Sprite();
			var g:Graphics = mask.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, 266, 290 );
			g.endFill();
			_cntContent.addChild( mask );
			
			_scrollBar = new VScrollbar( new GScrollbarBackground(), new GScrollbarSlider() );
			_scrollBar.addEventListener( VScrollbar.DRAG_START, dragStartHandler, false, 0, true );
			_scrollBar.addEventListener( VScrollbar.DRAG_STOP, dragStopHandler, false, 0, true );
			_scrollBar.link( _cntApercus, mask );
			_scrollBar.x = 275;
			_scrollBar.y = 90;
			addChild( _scrollBar );
			_scrollBar.enableBlur = true;
		}
		
		private function loadXml( xmlName:String ):void
		{
			_datasLoader = new DatasLoader( Configuration.pathXML + "/" + xmlName );
			_datasLoader.addEventListener( Event.COMPLETE, datasLoaderCompleteHandler, false, 0, true );
			_datasLoader.load();
		}
		
		private function build():void
		{
			var apercu:Apercu;
			trace( _challenges );
			var i:int, n:int = _challenges.length, py:int;
			for ( ; i < n; ++i )
			{
				apercu = new Apercu( _challenges[ i ] );
				apercu.y = py;
				_cntApercus.addChild( apercu );
				
				py += apercu.height;
			}
			
			activate();
		}
		
		private function resetChallenges():void
		{
			_challenges = null;			
			while ( _cntApercus.numChildren ) _cntApercus.removeChildAt( 0 );
		}
		
		private function onSwitchSousRub():void
		{
			var xmlName:String;
			switch( _currentSousRub )
			{
				case SousRubsIds.ELIVES_LIST_ENVOYES:
					_sousMenu.reset();
					_sousMenu.addItem( "En cours", SousRubsIds.ELIVES_LISTS_ENVOYES_ENCOURS );
					_sousMenu.addItem( "Terminés", SousRubsIds.ELIVES_LISTS_ENVOYES_TERMINES );
					_sousMenu.x = 288 * .5 - _sousMenu.width * .5;
					
					_currentSousRub = SousRubsIds.ELIVES_LISTS_ENVOYES_ENCOURS;
					onSwitchSousRub();
					break;
				case SousRubsIds.ELIVES_LIST_RECUS:
					_sousMenu.reset();
					_sousMenu.addItem( "En cours", SousRubsIds.ELIVES_LISTS_RECUS_ENCOURS );
					_sousMenu.addItem( "En attente", SousRubsIds.ELIVES_LISTS_RECUS_ATTENTE );
					_sousMenu.addItem( "Terminés", SousRubsIds.ELIVES_LISTS_RECUS_TERMINES );
					_sousMenu.x = 288 * .5 - _sousMenu.width * .5;
					
					_currentSousRub = SousRubsIds.ELIVES_LISTS_RECUS_ENCOURS;
					onSwitchSousRub();
					break;
				case SousRubsIds.ELIVES_LISTS_ENVOYES_ENCOURS: loadXml( "actions_list_encours.xml" ); break;
				case SousRubsIds.ELIVES_LISTS_ENVOYES_TERMINES: loadXml( "actions_list_termines.xml" ); break;
				case SousRubsIds.ELIVES_LISTS_RECUS_ENCOURS: loadXml( "actions_list_encours.xml" ); break;
				case SousRubsIds.ELIVES_LISTS_RECUS_ATTENTE: loadXml( "actions_list_attente.xml" ); break;
				case SousRubsIds.ELIVES_LISTS_RECUS_TERMINES: loadXml( "actions_list_termines.xml" ); break;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function activate():Boolean 
		{
			if ( _activated ) return false;
			
			_cntApercus.addEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true );
			_cntApercus.addEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true );
			_cntApercus.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true );
			
			_menu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler, false, 0, true )
			_sousMenu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler, false, 0, true );
			
			_scrollBar.addEventListener( VScrollbar.DRAG_START, dragStartHandler, false, 0, true );
			_scrollBar.addEventListener( VScrollbar.DRAG_STOP, dragStopHandler, false, 0, true );
			
			return _activated = true;
		}
		
		override public function deactivate():Boolean 
		{
			if ( !_activated ) return false;
			
			_cntApercus.removeEventListener( MouseEvent.MOUSE_OVER, mouseOverHandler );
			_cntApercus.removeEventListener( MouseEvent.MOUSE_OUT, mouseOutHandler );
			_cntApercus.removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			
			_menu.removeEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler );
			_sousMenu.removeEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler );
			
			_scrollBar.removeEventListener( VScrollbar.DRAG_START, dragStartHandler );
			_scrollBar.removeEventListener( VScrollbar.DRAG_STOP, dragStopHandler );
			
			return _activated = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}