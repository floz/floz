
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
	import video.VideoPlayer02;
	
	public class Main extends Sprite 
	{
		private var p:VideoPlayer02;
		private var idx:int;
		private var timeline:Sprite;
		
		private var cursor:Sprite;
		
		private var temp:Number;
		private var loadBar:Sprite;
		
		public function Main():void 
		{
			p = new VideoPlayer02();
			addChild( p );
			
			p.preload( "siera duel_40_4.flv", true );
			
			timeline = new Sprite();
			timeline.x = 20;
			timeline.y = 400;
			addChild( timeline );
			createTimeLine();
		}
		
		private function createTimeLine():void
		{			
			var g:Graphics;
			
			var bg:Shape = new Shape();
			g = bg.graphics;
			g.beginFill( 0x333333 );
			g.drawRect( 0, 0, 200, 5 );
			g.endFill();
			
			loadBar = new Sprite();
			g = loadBar.graphics;
			g.beginFill( 0x000000 );
			g.drawRect( 0, 0, 200, 5 );
			g.endFill();
			
			cursor = new Sprite();
			g = cursor.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, 20, 10 );
			g.endFill();
			
			cursor.y = -2.5;
			
			timeline.addChild( bg );
			timeline.addChild( loadBar );
			timeline.addChild( cursor );
			
			loadBar.addEventListener( MouseEvent.CLICK, onClick );
			
			cursor.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			cursor.x = e.localX - ( cursor.width * .5 );
			
			p.clickToSecond( e.localX, 200 );
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			removeEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			//temp = stage.mouseX - ( cursor.width + cursor.width * .5 );
//
			//if ( temp <= ( loadBar.x ) )
			//{
				//cursor.x = loadBar.x;
			//}
			//else if ( temp >= (loadBar.x + loadBar.width - cursor.width) )
			//{
				//cursor.x = loadBar.x + loadBar.width - cursor.width;
			//}
			//else
			//{
				//cursor.x = temp;
			//}
			cursor.x =  p.dragToSecond( stage.mouseX, loadBar.x, loadBar.width, cursor.width );
		}
		
	}
	
}