
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import fl.video.FLVPlayback;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Player extends Sprite 
	{
		public var vdo:FLVPlayback;
		
		private var flv:String;
		
		public function Player( flv:String ) 
		{
			this.flv = flv;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			Tweener.removeTweens( this );
			Tweener.removeTweens( vdo );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			this.x = stage.stageWidth * .5;
			this.y = stage.stageHeight * .5;
			this.scaleX =
			this.scaleY = 0;
		}
		
		// PRIVATE
		
		private function deleting():void
		{
			stop();
			parent.removeChild( this );
		}
		
		// PUBLIC
		
		public function init():void
		{			
			Tweener.addTween( this, { scaleX: 1, scaleY:1, time: .4, transition: "easeInOutExpo", onComplete: play } );
		}
		
		public function destroy():void
		{
			Tweener.addTween( vdo, { volume: 0, time: .4, transition: "easeOutQuad" } );
			Tweener.addTween( this, { scaleX: 0, scaleY:0, time: .4, transition: "easeInOutExpo", onComplete: deleting } );
		}
		
		public function play():void
		{
			vdo.play( flv );
		}
		
		public function stop():void
		{
			vdo.stop();
		}
		
	}
	
}