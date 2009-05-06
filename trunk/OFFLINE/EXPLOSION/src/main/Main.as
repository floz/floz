
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.animation.rain.Rain;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var v:Vignette = new Vignette();
			v.x = stage.stageWidth * .5 - v.width * .5;
			v.y = stage.stageHeight * .5 - v.height * .5;
			addChild( v );
			
			var e:Rain = Rain.apply( v );
			e.addEventListener( Event.COMPLETE, onComplete );
		}
		
		private function onComplete(e:Event):void 
		{
			trace( Rain.numExplosions );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}