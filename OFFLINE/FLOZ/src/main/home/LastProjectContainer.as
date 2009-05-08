
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main.home 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.easing.Cubic;
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
			
			msk.y = -msk.height;
			TweenLite.to( msk, .4, { y: 0, ease: Cubic.easeIn, delay: parent.numChildren * .1, onComplete: showTitle } );
			
			lastProject.addEventListener( Event.COMPLETE, onLastProjectDestroy );
			
			msk.mouseChildren = false;
			msk.mouseEnabled = false;
		}
		
		private function onLastProjectDestroy(e:Event):void 
		{
			TweenLite.to( msk, .4, { y: msk.height, ease: Cubic.easeOut, onComplete: destroy } );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function showTitle():void
		{
			lastProject.init();
		}
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function kill( delay:int ):void
		{
			lastProject.kill( delay );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}