
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package  
{
	import caurina.transitions.Tweener;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ToolTip extends Sprite 
	{
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var xVel:Number = 2;
		private var yVel:Number = 2;
		private var friction:Number = .98;
		
		public function ToolTip( width:Number, height:Number, ellipse:Number = 10, color:uint = 0x000000 ) 
		{
			var g:Graphics = this.graphics;
			g.beginFill( color );
			g.drawRoundRect( 0, -height, width, height, ellipse, ellipse );
			g.endFill();
			
			this.visible = false;
			this.scaleX = 0;
		}
		
		// EVENTS
		
		private function onMove(e:MouseEvent):void 
		{
			this.x = e.stageX + 10;
			this.y = e.stageY - 10;
			
			//Tweener.addTween( this, { x: e.stageX + 10, y: e.stageY - 10, time: .1, transition: "linear"  } )
			//
			//vx = e.stageX + 10;
			//vy = e.stageY - 10;
			//
			//xVel = ( e.stageX - this.x ) / 10;
			//yVel = ( e.stageY - this.y ) / 10;
			//
			//if ( !hasEventListener( Event.ENTER_FRAME ) ) addEventListener( Event.ENTER_FRAME, onFrame );
			
			e.updateAfterEvent();
		}
		
		private function onFrame(e:Event):void 
		{
			if ( this.x == vx && this.y == vy ) removeEventListener( Event.ENTER_FRAME, onFrame );
			
			if ( this.x >= vx + 1 || this.x <= vx - 1 ) this.x += xVel;
			if ( this.y >= vy + 1 || this.y <= vy - 1 ) this.y += yVel;
			
			xVel *= friction;
			yVel *= friction;
		}
		
		// PRIVATE
		
		private function disable():void
		{
			friction = 1;
			
			this.visible = false;
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMove );
		}
		
		// PUBLIC
		
		public function activate():void
		{
			this.x = stage.mouseX + 10;
			this.y = stage.mouseY - 10;
			
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMove );
			
			this.visible = true;
			Tweener.addTween( this, { alpha: 1, scaleX: 1, time: .4, transition: "easeInOutExpo" } );
		}
		
		public function desactivate():void
		{
			friction = .95;
			Tweener.addTween( this, { alpha: 0, scaleX: 0, time: .4, transition: "easeInOutExpo", onComplete: disable } );
		}
		
	}
	
}