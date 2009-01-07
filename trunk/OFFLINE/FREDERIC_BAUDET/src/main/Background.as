
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.Tweener;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Background extends MovieClip 
	{
		private var bg:MovieClip;
		
		public function Background() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			bg = new MovieClip();
			addChild( bg );
			
			var g:Graphics = bg.graphics;
			g.beginFill( Const.PUB_COLOR );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			
			ColorShortcuts.init();
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function changeColor( color:uint ):void
		{
			Tweener.addTween( bg, { _color: color, time: .4, transition: "easeOutQuad" } );
		}
		
	}
	
}