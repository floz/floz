
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
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class ToolTip extends MovieClip
	{
		public var title:TextField;
		public var subtitle:TextField;
		public var director:TextField;
		public var sound:TextField;
		
		public function ToolTip() 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.visible = false;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			TweenLite.killTweensOf( this );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		// PRIVATE
		
		// PUBLIC
		
		private function disable():void
		{			
			this.visible = false;
			parent.removeChild( this );
		}
		
		// PUBLIC
		
		public function activate( target:DisplayObject, title:String, subtitle:String, director:String, sound:String ):void
		{
			this.x = target.x;
			this.y = target.y - target.height / 4 - 10;
			
			this.title.text = title;
			this.director.text = director == "" ? "" : "Director : " + director;
			this.sound.text = sound == "" ? "" : "Music/Sound : " + sound;
			this.subtitle.text = subtitle || "";
			
			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			this.title.setTextFormat( tf );
			
			this.visible = true;
			TweenLite.to( this, .2, { alpha: .9, y: this.y + 10, ease: Quad.easeOut } );
		}
		
		public function desactivate():void
		{
			TweenLite.to( this, .2, { alpha: 0, y: this.y - 10, ease: Quad.easeOut, onComplete: disable } );
		}
		
	}
	
}