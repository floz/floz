
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import fl.video.VideoPlayer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Player extends Sprite
	{
		private var vWidth:Number;
		private var vHeight:Number;
		private var player:VideoPlayer;
		
		public function Player( vWidth:Number, vHeight:Number ) 
		{
			this.vWidth = vWidth;
			this.vHeight = vHeight;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			player = new VideoPlayer( vWidth, vHeight );
			addChild( player );
			
			
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function play():void
		{
			player.play();
		}
		
		public function close():void
		{
			player.close();
		}
		
	}
	
}