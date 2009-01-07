
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Tooltip extends MovieClip
	{
		public var title:TextField;
		public var director:TextField;
		public var sound:TextField;
		
		public function Tooltip() 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.visible = false;
		}
		
		// EVENTS
		
		// PRIVATE
		
		// PUBLIC
		
		private function disable():void
		{			
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
			this.sound.text = sound == "" ? sound : "Sound : " + sound;
			
			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			this.title.setTextFormat( tf );
			
			this.visible = true;
			Tweener.addTween( this, { alpha: 1, y: this.y + 10, time: .2, transition: "easeOutQuad" } );
		}
		
		public function desactivate():void
		{
			Tweener.addTween( this, { alpha: 0, y: this.y - 10, time: .2, transition: "easeOutQuad", onComplete: disable } );
		}
		
	}
	
}