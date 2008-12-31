
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
		private var particles:Sprite;		
		private var aParticles:Array;
		
		private var ready:Boolean;
		private var running:Boolean;
		
		public function Bulle( size:Number = 50 )
		{
			this.size = size;
			
			particles = new Sprite();
			addChild( particles );
			
			shape = new Sprite();
			var g:Graphics = shape.graphics;
			g.beginFill( 0x000000 );
			g.drawCircle( 0, 0, size );
			g.endFill();
			addChild( shape );
			
			//addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			var n:int = aParticles.length;
			for ( var i:int; i < n; i++ ) aParticles[ i ] = null;
			aParticles = null;
			
			Tweener.removeTweens( shape );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			shape.scaleX =
			shape.scaleY = 0;
		}
		
		private function onFrame(e:Event):void 
		{
			var p:Particle;
			
			var n:int = aParticles.length;
			for ( var i:int; i < n; i++ )
				Particle( aParticles[ i ] ).move();
			
			p = new Particle( n, randRange( 8, 15 ) );
			p.xVel = randRange( -8, 8 );
			p.yVel = randRange( -8, 8 );
			particles.addChild( p );
			
			aParticles.push( p );
			
			if ( ( n + 1 ) >= 30 ) 
			{
				removeEventListener( Event.ENTER_FRAME, onFrame );
				
				for ( i = 0; i < ( n + 1 ); i++ )
					Particle( aParticles[ i ] ).destroy();
			}
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
			Tweener.addTween( shape, { scaleX: 1.2, scaleY: 1.2, time: .3, transition: "easeInOutQuad", onComplete: bubble() } );
		}
		
		public function normalize():void
		{
			Tweener.addTween( shape, { scaleX: 1, scaleY: 1, time: .3, transition: "easeInOutQuad", onComplete: killBubbles() } );
		}
		
		public function bubble():void
		{
			if ( !ready || running ) return;
			running = true;
			
			aParticles = [];			
			//while ( particles.numChildren ) particles.removeChildAt( 0 );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		public function killBubbles():void
		{
			removeEventListener( Event.ENTER_FRAME, onFrame );
			
			var n:int = aParticles.length;
			for ( var i:int; i < n; i++ ) Particle( aParticles[ i ] ).destroy();
			
			aParticles = null;
			
			running = false;
		}
	}
	
}