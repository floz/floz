﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives 
{
	import elive.events.SectionEvent;
	import elive.rubriques.IRubrique;
	import elive.rubriques.Rubrique;
	import elives.sections.list.ElivesList;
	import elives.sections.sheet.ElivesSheet;
	import flash.events.Event;
	import fr.minuit4.core.configuration.Configuration;
	
	public class Main extends Rubrique implements IRubrique
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			init();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			_sectionsController.addEventListener( SectionEvent.SWITCH_SECTION, switchSectionHandler, false, 0, true );
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
			
			_sectionsController.addEventListener( SectionEvent.SWITCH_SECTION, switchSectionHandler, false, 0, true );
		}
		
		private function switchSectionHandler(e:SectionEvent):void 
		{
			e.stopImmediatePropagation();
			navigateTo( e.sectionId, e.id );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{			
			_sectionsController.addSection( new ElivesList(), ElivesList.SECTION_ID );
			_sectionsController.addSection( new ElivesSheet(), ElivesSheet.SECTION_ID );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function navigateTo( sectionId:int, id:int ):void
		{
			_sectionsController.navigateTo( sectionId, id );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}