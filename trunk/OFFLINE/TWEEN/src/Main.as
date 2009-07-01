
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import fr.minuit4.motion.M4Tween;
	import gs.TweenLite;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			var mov:Sprite = new Sprite();
			addChild( mov );
			
			var g:Graphics = mov.graphics;
			g.beginFill( 0xff00ff );
			g.drawCircle( 0, 0, 20 );
			g.endFill();
			
			M4Tween.createTween( mov, .5, { x: 300, y: 20, onComplete: "lol" } );
			M4Tween.createTween( mov, .5, { x: 500, y: 20, onComplete: "lol" } );
			M4Tween.createTween( this, .2, { z: 2 } );
			
			M4Tween.disposeTweenOf( mov );
			
			mov.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			trace( e.toString() );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}