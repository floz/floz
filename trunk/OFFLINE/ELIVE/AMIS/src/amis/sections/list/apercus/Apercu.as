
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package amis.sections.list.apercus
{
	import assets.GApercu;
	import aze.motion.Eaze;
	import elive.core.users.User;
	import flash.events.Event;
	
	public class Apercu extends GApercu
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Apercu() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function removedFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			Eaze.killTweensOf( apercuOver );
			
			apercuOver = null;
			tf = null;			
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function init():void
		{
			this.mouseChildren = false;
			
			apercuOver.alpha = 0;			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			apercuOver.alpha = .4;
			Eaze.to( apercuOver, .25, { alpha: 1 } );
		}
		
		public function out():void
		{
			apercuOver.alpha = .6;
			Eaze.to( apercuOver, .25, { alpha: 0 } );
		}
		
		public function getId():int { return 0; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}