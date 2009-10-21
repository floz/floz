
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elives.sections.sheet 
{
	import elive.core.challenges.Challenge;
	import elive.core.interfaces.ILinkable;
	import elive.core.users.User;
	import elive.ui.compteur.Compteur;
	import elive.ui.sousmenu.SousMenu;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.tools.scrollbars.VScrollbar;
	
	public class Sheet extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sousMenu:SousMenu;
		private var _challenge:Challenge;
		
		private var _compteur:Compteur;
		private var _cnt:Sprite;
		private var _scrollBar:VScrollbar;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Sheet() 
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
		
		private function build():void
		{
			_compteur = new Compteur();
			_compteur.x = 144 - _compteur.width * .5;
			_compteur.y = 88;
			_compteur.setEndTime( _challenge.endTime );
			addChild( _compteur );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkTo( challenge:Challenge ):void
		{
			this._challenge = challenge;
			build();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}