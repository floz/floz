
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
		public var msk1:Sprite;
		public var msk2:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AboutContainer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			TweenLite.killTweensOf( msk1 );
			TweenLite.killTweensOf( msk2 );
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			msk1.y =
			msk2.y = -msk1.height - 5;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			TweenLite.to( msk1, .4, { y: -5, ease: Cubic.easeIn } );
			TweenLite.to( msk2, .4, { y: -5, ease: Cubic.easeIn, delay: .1 } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}