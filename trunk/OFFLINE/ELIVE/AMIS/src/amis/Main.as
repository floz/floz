﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis 
{
	import amis.sections.list.EbuddiesList;
	import amis.sections.list.Menu;
	import amis.sections.sheet.EbuddySheet;
	import elive.navigation.NavIds;
	import elive.navigation.NavManager;
	import elive.rubriques.IRubrique;
	import elive.rubriques.Rubrique;
	import flash.events.Event;
	
	public class Main extends Rubrique
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _menu:Menu;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_sectionsController.addSection( new EbuddiesList(), EbuddiesList.SECTION_ID );
			_sectionsController.addSection( new EbuddySheet(), EbuddySheet.SECTION_ID );
			
			if ( _standalone )
			{
				navigateTo( 0 );
			}
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}