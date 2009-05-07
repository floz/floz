
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main.home 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class LastProjectContainer extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var lastProject:LastProject;
		public var msk:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LastProjectContainer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			TweenLite.killTweensOf( msk );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			msk.mouseChildren = false;
			msk.mouseEnabled = false;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			parent.removeChild( this );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function kill( delay:int ):void
		{
			TweenLite.to( msk, .4, { y: msk.height, ease: Quad.easeInOut, delay: delay / 8, onComplete: destroy } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}