
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
		private var playbar:Sprite;
		
		public function Main():void 
		{
			trace( "Main.Main" );
			p = new VideoPlayer02();
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
			var g:Graphics;
			
			var bg:Shape = new Shape();
			g = bg.graphics;
			g.lineStyle( 1, 0x444444 );
			g.drawRect( -2.5, -2.5, 205, 10 );
			g.endFill();
			
			loadBar = new Sprite();
			g = loadBar.graphics;
			g.beginFill( 0x000000 );
			g.drawRect( 0, 0, 200, 5 );
			g.endFill();
			
			playbar = new Sprite();
			g = playbar.graphics;
			g.beginFill( 0x0000FF );
			g.drawRect( 0, 0, 200, 5 );
			g.endFill();
			
			trace ( playbar.width );
			
			var bar:Sprite = new Sprite();
			bar.addChild( loadBar );
			bar.addChild( playbar );
			
			cursor = new Sprite();
			g = cursor.graphics;
			g.beginFill( 0xff00ff );
			g.drawRect( 0, 0, 20, 10 );
			g.endFill();
			
			cursor.y = -2.5;
			
			timeline.addChild( bg );
			timeline.addChild( bar );
			timeline.addChild( cursor );
			
			bar.addEventListener( MouseEvent.CLICK, onClick );
			bar.addEventListener( MouseEvent.ROLL_OVER, onOver );
			
			p.configTimeline( loadBar, playbar, bar, cursor );
			
			cursor.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			trace( "Main.onOver > e : " + e );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			trace( "Main.onClick > e : " + e );
			cursor.x = e.localX - ( cursor.width * .5 );
			
			p.clickToSecond( e.localX );
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
			cursor.x =  p.dragToSecond( stage.mouseX );
		}
		
	}
	
}