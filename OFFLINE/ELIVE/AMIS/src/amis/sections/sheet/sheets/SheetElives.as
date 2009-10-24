
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets 
{
	import amis.sections.sheet.sheets.elives.Menu;
	import elive.core.users.User;
	import elive.events.NavEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class SheetElives extends Sheet
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _menu:Menu;
		private var _cntSousRub:Sprite;
		
		private var _currentSousRub:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SheetElives() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);		
			
			_menu.removeEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_menu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler, false, 0, true );
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
			addChild( _menu );
			
			_cntSousRub = new Sprite();
			_cntSousRub = _menu.height - 20;
			addChild( _cntSousRub );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function onSwitchSousRub():void
		{
			trace( "SheetElives.onSwitchSousRub" );
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function linkTo(user:User):void 
		{
			super.linkTo(user);
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}