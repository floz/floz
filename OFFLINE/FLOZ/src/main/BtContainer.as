
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.easing.Cubic;
	import gs.TweenLite;
	
	public class BtContainer extends MovieClip
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var msk1:Sprite;
		public var msk2:Sprite;
		public var btPrev:Bt;
		public var btNext:Bt;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function BtContainer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			TweenLite.killTweensOf( msk1 );
			TweenLite.killTweensOf( msk2 );
			TweenLite.killTweensOf( btNext );
			TweenLite.killTweensOf( btPrev );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			msk1.y =
			msk2.y = 50;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function showPrev():void
		{
			if ( msk1.y == 0 ) return;
			TweenLite.to( msk1, .2, { y: 0, ease: Cubic.easeOut } );
		}
		
		public function showNext():void
		{
			if ( msk2.y == 0 ) return;
			TweenLite.to( msk2, .2, { y: 0, ease: Cubic.easeOut } );
		}
		
		public function hidePrev():void
		{
			if ( msk1.y == 50 ) return;
			TweenLite.to( msk1, .2, { y: 50, ease: Cubic.easeOut } );
		}
		
		public function hideNext():void
		{
			if ( msk2.y == 50 ) return;
			TweenLite.to( msk2, .2, { y: 50, ease: Cubic.easeOut } );
		}
		
		public function activateNext():void
		{
			btNext.enable = true;
			TweenLite.to( btNext, .2, { alpha: 1, ease: Cubic.easeOut } );
		}
		
		public function deactivateNext():void
		{
			btNext.enable = false;
			TweenLite.to( btNext, .2, { alpha: .5, ease: Cubic.easeOut } );
		}
		
		public function activatePrev():void
		{
			btPrev.enable = true;
			TweenLite.to( btPrev, .2, { alpha: 1, ease: Cubic.easeOut } );
		}
		
		public function deactivatePrev():void
		{
			btPrev.enable = false;
			TweenLite.to( btPrev, .2, { alpha: .5, ease: Cubic.easeOut } );
		}
		
		public function kill():void
		{
			TweenLite.to( msk1, .4, { y: 50, ease: Cubic.easeOut } );
			TweenLite.to( msk2, .4, { y: 50, ease: Cubic.easeOut, onComplete: destroy } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}