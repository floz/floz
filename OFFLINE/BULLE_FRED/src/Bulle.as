
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package  
{
	import caurina.transitions.Tweener;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bulle extends Sprite
	{
		private var size:Number;
		private var shape:Shape;
		
		private var ready:Boolean;
		
		public function Bulle( size:Number = 50 )
		{
			this.size = size;
			
			shape = new Shape();
			var g:Graphics = shape.graphics;
			g.beginFill( 0x000000 );
			g.drawCircle( 0, 0, size );
			g.endFill();
			addChild( shape );
			
			var particles:Sprite = new Sprite();
			addChild( particles );
			
			var preview:Sprite = new Sprite();
			addChild( preview );
			
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
			
			shape.scaleX =
			shape.scaleY = 0;
		}
		
		// PRIVATE
		
		private function setReadyOn():void { this.ready = true; }
		
		private function setReadyOff():void { this.ready = false;  this.parent.removeChild( this ) }
		
		// PUBLIC
		
		public function appear():void
		{
			Tweener.addTween( shape, { scaleX: 1, scaleY: 1, time: .35, transition: "easeInOutQuad", onComplete: setReadyOn() } );
		}
		
		public function destroy():void
		{
			Tweener.addTween( shape, { scaleX: 0, scaleY: 0, time: .35, transition: "easeInOutQuad", onComplete: setReadyOn() } );
		}
		
		public function bubble():void
		{
			if ( !ready ) return;			
		}
		
		public function enlarge():void
		{
			Tweener.addTween( shape, { scaleX: 1.2, scaleY: 1.2, time: .3, transition: "easeInOutQuad", onComplete: setReadyOn() } );
		}
		
		public function normalize():void
		{
			Tweener.addTween( shape, { scaleX: 1, scaleY: 1, time: .3, transition: "easeInOutQuad", onComplete: setReadyOn() } );
		}
	}
	
}