
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package profil 
{
	import elive.rubriques.IRubrique;
	import elive.rubriques.Rubrique;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Rubrique implements IRubrique
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			trace( "0:Rubrique 'Profil' loaded" );
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
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
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function navigateTo( sectionId:int, id:int ):void
		{
			
		}
	}
	
}