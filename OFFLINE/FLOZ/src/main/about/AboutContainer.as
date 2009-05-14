
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.about 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.easing.Cubic;
	import gs.TweenLite;
	import main.about.AboutContent;
	
	public class AboutContainer extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var aboutContent:AboutContent;
		public var aboutPhoto:AboutPhoto;
		public var msk:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AboutContainer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			TweenLite.killTweensOf( msk );
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			msk.y = -msk.height - 5;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			TweenLite.to( msk, .4, { y: -5, ease: Cubic.easeIn } );
		}
		
		public function deactivate():void
		{
			TweenLite.to( msk, .4, { y: -msk.height - 5, ease: Cubic.easeOut, onComplete: destroy } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}