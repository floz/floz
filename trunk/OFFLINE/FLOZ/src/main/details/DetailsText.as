
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DetailsText extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _project:Object;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var strkTxt:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DetailsText() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( project:Object ):void
		{
			this._project = project;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}