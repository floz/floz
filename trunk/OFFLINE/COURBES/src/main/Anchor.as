
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Anchor extends Sprite
	{
		private var _outline:Shape;
		
		public function Anchor() 
		{
			this.graphics.beginFill( 0x3300CC ); 
			this.graphics.drawCircle( -15 * .5, -15 * .5, 15 );
			this.graphics.endFill();
			
			_outline = new Shape ();
			_outline.graphics.lineStyle( 4, 0xFF0000 );
			_outline.graphics.drawCircle( -15 * .5, -15 * .5, 15 );
			_outline.graphics.endFill();
			addChild( _outline );
			
			_outline.visible = false;
			
			this.buttonMode = true;
			this.mouseEnabled = true;
			
			addEventListener( MouseEvent.MOUSE_OVER, onOver );
			addEventListener( MouseEvent.MOUSE_OUT, onOut );
		}
		
		// EVENTS
		
		private function onOver(e:MouseEvent):void 
		{
			_outline.visible = true;
		}
		
		private function onOut(e:MouseEvent):void 
		{
			_outline.visible = false;
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}