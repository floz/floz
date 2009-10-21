
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.list 
{
	import elive.events.NavEvent;
	import elive.rubriques.sections.Section;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ElivesList extends Section
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _menu:Menu;
		private var _cntSousRub:Sprite;
		
		private var _currentSousRub:String;
		
		private var _activated:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ElivesList() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0,  true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		private function switchSousRubHandler( e:NavEvent ):void
		{
			e.stopImmediatePropagation();
			
			if ( _currentSousRub ==e.navId ) 
				return;
			
			_currentSousRub = e.navId;
			onSwitchSousRub();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_currentSousRub = SousRubsIds.LIST_RECUS;
			
			_menu = new Menu();
			_menu.x = 3;
			addChild( _menu );
			
			_cntSousRub = new Sprite();
			_cntSousRub.y = 53;
			addChild( _cntSousRub );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0,  true );
		}
		
		private function onSwitchSousRub():void
		{
			while ( _cntSousRub.numChildren ) _cntSousRub.removeChildAt( 0 );
			
			if ( _currentSousRub == SousRubsIds.LIST_RECUS )
				_cntSousRub.addChild( new ListRecus() );
			else if ( _currentSousRub == SousRubsIds.LIST_ENVOYES )
				_cntSousRub.addChild( new ListEnvoyes() );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function activate():void
		{
			if ( _activated ) return;
			_menu.addEventListener( NavEvent.SWITCH_RUBRIQUE, switchSousRubHandler, false, 0, true );
			_activated = true;
		}
		
		override public function deactivate():void
		{
			if ( !_activated ) return;
			_menu.removeEventListener( NavEvent.SWITCH_RUBRIQUE, switchSousRubHandler );
			_activated = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}