
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fr.minuit4.animation.rain.Rain;
	import fr.minuit4.animation.rain.RainBack;
	import fr.minuit4.utils.debug.FPS;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:Sprite;
		private var v:Bitmap;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			v = new Bitmap( new VignetteBmp( 0, 0 ), PixelSnapping.AUTO, true );
			v.x = stage.stageWidth * .5 - v.width * .5;
			v.y = stage.stageHeight * .5 - v.height * .5 + 10;
			cnt.addChild( v );
			
			addChild( new FPS( 250, 50, false ) );
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			
			var r:Rain = new Rain( v );
			r.x = v.x;
			r.y = v.y;
			
			cnt.addChild( r );
			
			r.start();
			
			r.addEventListener( Event.COMPLETE, onComplete );
		}
		
		private function onComplete(e:Event):void 
		{
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			
			var r:RainBack = new RainBack( v );
			r.x = v.x;
			r.y = v.y;
			cnt.addChild( r );
			
			r.start();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}