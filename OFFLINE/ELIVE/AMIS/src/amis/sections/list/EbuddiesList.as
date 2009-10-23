
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list 
{
	import amis.sections.list.lists.ListAmis;
	import amis.sections.list.lists.ListGroupes;
	import elive.core.interfaces.ILinkable;
	import elive.events.NavEvent;
	import elive.rubriques.sections.Section;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.core.interfaces.IDisposable;
	
	public class EbuddiesList extends Section implements ILinkable, IDisposable
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _menu:Menu;
		private var _cntSousRub:Sprite;
		
		private var _currentSousRub:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 0;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EbuddiesList() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		private function switchSousRubHandler( e:NavEvent ):void
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
			_menu = new Menu();
			_menu.x = 3;
			addChild( _menu );
			
			_cntSousRub = new Sprite();
			_cntSousRub.y = 40;
			addChild( _cntSousRub );
			
			_currentSousRub = SousRubIds.AMIS;
			onSwitchSousRub();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function onSwitchSousRub():void
		{
			while ( _cntSousRub.numChildren ) _cntSousRub.removeChildAt( 0 );
			
			if ( _currentSousRub == SousRubIds.AMIS )
				_cntSousRub.addChild( new ListAmis() );
			else if ( _currentSousRub == SousRubIds.GROUPES )
				_cntSousRub.addChild( new ListGroupes() );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function activate():void 
		{
			if ( _activated ) return;
			_menu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler, false, 0, true );
			_activated = true;
		}
		
		override public function deactivate():void 
		{
			if ( !_activated ) return;
			_menu.removeEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler );
			_activated = false;
		}
		
		override public function dispose():void
		{
			_menu.dispose();
			_menu = null;
			
			IDisposable( _cntSousRub.getChildAt( 0 ) ).dispose();
			_cntSousRub = null;
		}		
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}