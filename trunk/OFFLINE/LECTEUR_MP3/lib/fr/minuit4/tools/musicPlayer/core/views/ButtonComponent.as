
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	
	public class ButtonComponent extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		protected var _musicManager:MusicManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ButtonComponent() 
		{
			_musicManager = MusicManager.getInstance();
			this.buttonMode = true;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			
			removeEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );			
			addEventListener( MouseEvent.CLICK, onClick );	
		}
		
		protected function onClick(e:MouseEvent):void 
		{
			// ABSTRACT METHOD - must be overrided
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
	}
	
}