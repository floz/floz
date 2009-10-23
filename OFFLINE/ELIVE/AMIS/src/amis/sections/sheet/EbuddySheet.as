
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.sheet 
{
	import elive.rubriques.sections.Section;
	import flash.events.Event;
	
	public class EbuddySheet extends Section
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const SECTION_ID:int = 1;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EbuddySheet() 
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
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
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
			
		}		
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}