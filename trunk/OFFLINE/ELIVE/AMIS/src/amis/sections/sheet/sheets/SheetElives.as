
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet.sheets 
{
	import amis.sections.sheet.sheets.elives.ListEnvoyes;
	import amis.sections.sheet.sheets.elives.ListRecus;
	import amis.sections.sheet.sheets.elives.Menu;
	import amis.sections.sheet.sheets.elives.SousRubIds;
	import elive.core.users.User;
	import elive.events.NavEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.core.interfaces.IDisposable;
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
			_menu = null;
			
			_cntSousRub = null;
			
			dispose();
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_menu.addEventListener( NavEvent.SWITCH_SOUS_RUBRIQUE, switchSousRubHandler, false, 0, true );
			
			if( !_currentSousRub ) _currentSousRub = SousRubIds.RECUS;
			onSwitchSousRub();
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
			_cntSousRub.y = _menu.height - 25;
			addChild( _cntSousRub );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		private function onSwitchSousRub():void
		{
			while ( _cntSousRub.numChildren ) 
				IDisposable( _cntSousRub.removeChildAt( 0 ) ).dispose();
			
			if ( _currentSousRub == SousRubIds.RECUS )
				_cntSousRub.addChild( new ListRecus() );
			else if ( _currentSousRub == SousRubIds.ENVOYES )
				_cntSousRub.addChild( new ListEnvoyes() );
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