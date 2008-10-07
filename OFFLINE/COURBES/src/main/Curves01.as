
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Curves01 extends MovieClip
	{
		private var _currentTarget:Sprite;
		
		private var _a1:Anchor;
		private var _a2:Anchor;
		
		public function Curves01() 
		{
			_a1 = new Anchor();
			_a1.x = Math.random() * stage.stageWidth;
			_a1.y = Math.random() * stage.stageHeight;
			addChild( _a1 );
			
			_a2 = new Anchor();
			_a2.x = Math.random() * stage.stageWidth;
			_a2.y = Math.random() * stage.stageHeight;
			addChild( _a2 );
			
			_a1.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			_a2.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
		}
		
		// EVENTS
		
		private function onDown( e:MouseEvent ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onUp );
			
			_currentTarget = e.currentTarget as Sprite;
			_currentTarget.startDrag();
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, onUp );
			
			_currentTarget.stopDrag();
			removeEventListener( Event.ENTER_FRAME, onFrame );
			_currentTarget = null;
		}
		
		private function onFrame(e:Event):void 
		{
			
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}