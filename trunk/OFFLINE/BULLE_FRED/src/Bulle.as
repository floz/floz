
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
		private var shape:Sprite;
		private var normalSize:Number;
		private var enlargedSize:Number;
		
		private var ready:Boolean;
		private var running:Boolean;
		
		public function Bulle( size:Number = 50 )
		{
			this.size = size;
			
			shape = new Sprite();
			var g:Graphics = shape.graphics;
			g.beginFill( 0x000000 );
			g.drawCircle( 0, 0, size );
			g.endFill();
			addChild( shape );
			
			normalSize = this.width;
			enlargedSize = this.width * 1.2;
			
			this.buttonMode = true;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			Tweener.removeTweens( shape );
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
		
		private function setReadyOff():void { this.ready = false; this.parent.removeChild( this ); }
		
		private function randRange( min:Number, max:Number, plus:Number = 0 ):Number
		{
			var n:Number = ( Math.random() * ( max - min ) + min )
			return  n = ( n < 0 ) ? n - plus : n + plus;
		}
		
		// PUBLIC
		
		public function appear():void
		{
			Tweener.addTween( shape, { scaleX: 1, scaleY: 1, time: .35, transition: "easeInOutQuad", onComplete: setReadyOn() } );
		}
		
		public function destroy():void
		{
			Tweener.addTween( shape, { scaleX: 0, scaleY: 0, time: .35, transition: "easeInOutQuad", onComplete: setReadyOff() } );
		}
		
		public function enlarge():void
		{
			Tweener.addTween( shape, { width: enlargedSize, height: enlargedSize, time: .3, transition: "easeInOutExpo" } );
		}
		
		public function normalize():void
		{
			Tweener.addTween( shape, { width: normalSize, height: normalSize, time: .3, transition: "easeInOutBack" } );
		}
	}
	
}