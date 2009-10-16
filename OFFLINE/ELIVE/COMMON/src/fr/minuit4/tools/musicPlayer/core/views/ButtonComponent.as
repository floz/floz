
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
			this.buttonMode = true;			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		protected function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			
			removeEventListener( MouseEvent.CLICK, onClick );
			
			_musicManager = null;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		protected function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_musicManager = MusicManager.getInstance();			
			addEventListener( MouseEvent.CLICK, onClick, false, 0, true );	
		}
		
		protected function onClick(e:MouseEvent):void 
		{
			// ABSTRACT METHOD - must be overrided
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void
		{
			if ( hasEventListener( Event.REMOVED_FROM_STAGE ) ) removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( MouseEvent.CLICK, onClick );
			
			_musicManager = null;
		}
		
	}
	
}