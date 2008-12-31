
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	
	public class Particle extends Shape
	{
		private var size:Number;
		private var index:int;
		private var color:uint;
		
		public var xVel:Number = 0;
		public var yVel:Number = 0;
		public var friction:Number = .95;
		public var fade:Number = .015;
		public var shrink:Number = .02;
		
		private var enabled:Boolean;
		
		public function Particle( index:int, size:Number = 5, color:uint = 0x000000 ) 
		{
			this.size = size;
			this.index = index;
			this.color = color;
			
			var g:Graphics = this.graphics;
			g.beginFill( color );
			g.drawCircle( 0, 0, size );
			g.endFill();
			
			enabled = true;
		}
		
		// EVENTS
		
		private function onFrame(e:Event):void 
		{
			if ( this.scaleX <= 0 || !enabled ) 
			{
				removeEventListener( Event.ENTER_FRAME, onFrame );				
				if ( this.parent ) this.parent.removeChild( this );
			}
			
			//this.alpha -= fade * 3;
			
			this.x += xVel;
			this.y += yVel;
			
			xVel *= friction;
			yVel *= friction;
			
			this.scaleX =
			this.scaleY -= shrink * 2;
		}
		
		// PRIVATE
		
		// PUBLIC
		
		public function move():void
		{
			if ( !enabled ) return;
			
			this.x += xVel;
			this.y += yVel;
			
			xVel *= friction;
			yVel *= friction;
			
			this.scaleX =
			this.scaleY -= shrink;
			
			//this.alpha -= fade;
			
			if ( this.alpha < 0 || this.scaleX < 0 ) enabled = false;
		}
		
		public function destroy():void
		{
			addEventListener( Event.ENTER_FRAME, onFrame );			
		}
		
	}
	
}