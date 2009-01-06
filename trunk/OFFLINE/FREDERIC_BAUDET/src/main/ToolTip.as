
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Tooltip extends Sprite 
	{
		public var title:TextField;
		public var director:TextField;
		public var sound:TextField;
		
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var xVel:Number = 2;
		private var yVel:Number = 2;
		private var friction:Number = .98;
		
		public function Tooltip() 
		{			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.visible = false;
		}
		
		// EVENTS
		
		private function onMove(e:MouseEvent):void 
		{
			this.x = e.stageX - 30;
			this.y = e.stageY - this.height - 10;
			
			e.updateAfterEvent();
		}
		
		// PRIVATE
		
		private function disable():void
		{
			friction = 1;
			
			this.visible = false;
			parent.removeChild( this );
		}
		
		// PUBLIC
		
		public function activate( target:DisplayObject, title:String, director:String, sound:String ):void
		{
			this.x = target.x;
			this.y = target.y - target.height / 4 + 10;
			
			this.title.text = title;
			this.director.text = "Director : " + director;
			this.sound.text = "Sound : " + sound;
			
			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			this.title.setTextFormat( tf );
			
			this.visible = true;
			Tweener.addTween( this, { alpha: 1, y: this.y + 10, time: .2, transition: "easeOutQuad" } );
		}
		
		public function desactivate():void
		{
			friction = .95;
			Tweener.addTween( this, { alpha: 0, y: this.y - 10, time: .2, transition: "easeOutQuad", onComplete: disable } );
		}
		
	}
	
}