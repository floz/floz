
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
	import flash.text.TextField;
	import video.Bar;
	import video.VideoPlayer;
	
	public class Main extends Sprite 
	{
		private var p:VideoPlayer;
		private var idx:int;
		private var timeline:Sprite;
		
		private var cursor:Sprite;
		
		private var temp:Number;
		private var loadBar:Sprite;
		private var playbar:Sprite;
		private var pause:Sprite;
		private var play:Sprite;
		
		public function Main():void 
		{
			p = new VideoPlayer( 400, 240 );
			addChild( p );
			
			timeline = new Sprite();
			timeline.x = 60;
			timeline.y = 400;
			addChild( timeline );
			createTimeLine();
			
			pause = new Sprite();
			pause.graphics.beginFill( 0xFF0000 );
			pause.graphics.drawRect( 0, 0, 10, 10 );
			pause.graphics.endFill();
			
			pause.x = pause.y = 300;
			addChild( pause );
			
			play = new Sprite();
			play.graphics.beginFill( 0x00FF00 );
			play.graphics.drawRect( 0, 0, 10, 10 );
			play.graphics.endFill();
			
			play.x = 280;
			play.y = 300;
			addChild( play );
			
			pause.addEventListener( MouseEvent.CLICK, onClick );
			play.addEventListener( MouseEvent.CLICK, onClick );
			
			p.play( "siera duel_40_4.flv" );
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch ( e.currentTarget )
			{
				case pause : p.pause(); break;
				case play : p.resume(); break;
			}
		}
		
		private function createTimeLine():void
		{
			var bar:Bar = new Bar( p );
			addChild( bar );
		}
		
	}
	
}