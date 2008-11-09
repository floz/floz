
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import video.Bar;
	import video.VideoPlayer03;
	
	public class Main extends Sprite 
	{
		private var p:VideoPlayer03;
		private var idx:int;
		private var timeline:Sprite;
		
		private var cursor:Sprite;
		
		private var temp:Number;
		private var loadBar:Sprite;
		private var playbar:Sprite;
		
		public function Main():void 
		{
			p = new VideoPlayer03();
			addChild( p );
			
			p.preload( "siera duel_40_4.flv", true );
			
			timeline = new Sprite();
			timeline.x = 60;
			timeline.y = 400;
			addChild( timeline );
			createTimeLine();
		}
		
		private function createTimeLine():void
		{
			var bar:Bar = new Bar( p );
			addChild( bar );
			
			//bar.addEventListener( MouseEvent.CLICK, onClick );
			
			//p.configTimeline( bar );
			
			//cursor.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			cursor.x = e.localX - ( cursor.width * .5 );
			
			//p.clickToSecond( e.localX );
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			p.pause();
			
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			removeEventListener( Event.ENTER_FRAME, onFrame );
			
			p.resume();
		}
		
		private function onFrame(e:Event):void 
		{
			//cursor.x =  p.dragToSecond( stage.mouseX );
		}
		
	}
	
}