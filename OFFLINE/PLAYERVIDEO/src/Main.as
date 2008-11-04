
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import video.VideoPlayer02;
	
	public class Main extends Sprite 
	{
		private var p:VideoPlayer02;
		private var idx:int;
		
		public function Main():void 
		{
			p = new VideoPlayer02();
			addChild( p );
			
			p.preload( "siera duel_40_4.flv" );
			
			var zStop:Sprite = new Sprite();
			zStop.graphics.beginFill( 0xFF0000 );
			zStop.graphics.drawRect( 0, 0, 20, 20 );
			zStop.graphics.endFill();
			
			zStop.x = 500;
			zStop.y = 400;
			addChild( zStop );		
		}
		
	}
	
}