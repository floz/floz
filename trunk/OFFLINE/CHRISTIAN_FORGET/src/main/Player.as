
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
	import flash.events.Event;
	
	public class Player extends MovieClip 
	{
		public var videoPlayer:FLVPlayback;
		
		public function Player() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			Tweener.removeTweens( videoPlayer );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			init();
		}
		
		// PRIVATE
		
		private function init():void
		{
			videoPlayer.setSize( 640, 360 );
			videoPlayer.skinAutoHide = true;
			videoPlayer.skinBackgroundAlpha = .9;
			videoPlayer.skinFadeTime = 300;
			
			videoPlayer.bufferTime = 3;
		}
		
		private function close():void
		{
			videoPlayer.stop();
			videoPlayer.visible = false;
		}
		
		// PUBLIC
		
		public function load( url:String ):void
		{
			show();
			videoPlayer.play( url );
			
			dispatchEvent( new Event( Event.INIT, true ) );
		}
		
		public function show():void
		{
			videoPlayer.alpha = .4;
			videoPlayer.volume = .4;
			videoPlayer.visible = true;
			Tweener.addTween( videoPlayer, { alpha: 1, volume: 1, transition: "easeInOutQuad", time: .8 } );
		}
		
		public function hide():void
		{
			Tweener.addTween( videoPlayer, { alpha: .6, volume: .4, transition: "easeInOutQuad", time: .4, onComplete: close } );
			videoPlayer.visible = false;
		}
		
	}
	
}