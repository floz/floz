
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bubbles extends Sprite 
	{
		private var size:Number;
		private var particles:Sprite;
		
		private var aParticles:Array;
		
		private var px:Number;
		private var py:Number;
		
		// Default var
		private var running:Boolean;
		public var xVel:int;
		public var yVel:int;
		
		public function Bubbles( size:Number = 50 ) 
		{
			this.size = size;
			
			particles = new Sprite();
			addChild( particles );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			var n:int = aParticles.length;
			for ( var i:int; i < n; i++ ) aParticles[ i ] = null;
			aParticles = null;
		}		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onFrame(e:Event):void 
		{
			var p:Particle;
			
			var n:int = aParticles.length;
			for ( var i:int; i < n; i++ )
				Particle( aParticles[ i ] ).move();
			
			var s:Number = size * .5;
			p = new Particle( px, py, randRange( s - 7, s ) );
			p.xVel = randRange( xVel - 2, xVel + 2 );
			p.yVel = randRange( yVel - 2, yVel + 2 );
			particles.addChild( p );
			
			aParticles.push( p );
			
			if ( ( n + 1 ) >= 15 ) 
			{
				removeEventListener( Event.ENTER_FRAME, onFrame );
				
				for ( i = 0; i < ( n + 1 ); i++ )
					Particle( aParticles[ i ] ).destroy();
			}
		}
		
		// PRIVATE
		
		private function randRange( min:Number, max:Number, plus:Number = 0 ):Number
		{
			var n:Number = ( Math.random() * ( max - min ) + min )
			return  n = ( n < 0 ) ? n - plus : n + plus;
		}
		
		// PUBLIC
		
		public function bubble( x:Number, y:Number ):void
		{
			if ( running ) return;
			running = true;
			
			this.px = x;
			this.py = y;
			
			aParticles = [];
			
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