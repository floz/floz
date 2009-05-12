
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.details 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.easing.Cubic;
	import gs.TweenLite;
	
	public class DetailsContainer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var dDiaporama:DetailsDiaporama;
		public var dText:DetailsText;
		public var msk1:Sprite;
		public var msk2:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DetailsContainer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			TweenLite.killTweensOf( msk1 );
			TweenLite.killTweensOf( dText );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			msk1.y = -msk1.height - 10;
			dText.alpha = 0;
			TweenLite.to( msk1, .4, { y: -5, ease: Cubic.easeIn, onComplete: onDiaporamaAppear } );
			TweenLite.to( dText, .2, { alpha: 1, ease: Cubic.easeIn, delay: .2 } );
			
			dDiaporama.addEventListener( Event.COMPLETE, onPanelComplete );
			
			this.x = 2;
		}
		
		private function onPanelComplete(e:Event):void 
		{
			TweenLite.to( msk1, .4, { y: msk1.height + 10, ease: Cubic.easeOut, onComplete: destroy } );
			TweenLite.to( dText, .4, { alpha: 0, ease: Cubic.easeOut } );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function onDiaporamaAppear():void
		{
			dDiaporama.showPanel();
		}
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}		
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( project:Object ):void
		{
			dDiaporama.linkToProject( project );
			dText.linkToProject( project );
		}
		
		public function kill():void
		{
			dDiaporama.hidePanel();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}