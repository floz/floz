
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ething 
{
	import assets.ething.GEthing1;
	import elive.events.EthingEvent;
	import elive.managers.EthingManager;
	import flash.events.Event;
	
	public class Ething extends GEthing1
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ethingManager:EthingManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Ething() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function animRequestHandler(e:EthingEvent):void 
		{
			gotoAndPlay( e.label );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_ethingManager = EthingManager.getInstance();
			_ethingManager.addEventListener( EthingEvent.ANIM_REQUEST, animRequestHandler );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}