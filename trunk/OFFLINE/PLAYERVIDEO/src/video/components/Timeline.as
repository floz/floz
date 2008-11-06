
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package video.components 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Timeline extends Sprite 
	{
		protected var background:Shape;
		protected var loadedBar:Sprite;
		protected var playedBar:Sprite;
		protected var cursor:MovieClip;
		
		public function Timeline( background:Shape, loadedBar:Sprite, playedBar:Sprite, cursor:MovieClip ) 
		{
			this.background = background;
			this.loadedBar = loadedBar;
			this.playedBar = playedBar;
			this.cursor = cursor;
			
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
		}
		
		// PRIVATE	
		
		// PUBLIC
		
	}
	
}