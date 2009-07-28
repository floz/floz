
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
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import fr.minuit4.motion.easing.Quad;
	import fr.minuit4.motion.M4Motion;
	import gs.TweenLite;
	
	public class Main extends Sprite
	{
		private var mov:Sprite;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			mov = new Sprite();
			addChild( mov );
			
			var g:Graphics = mov.graphics;
			g.beginFill( 0xff00ff );
			g.drawCircle( 0, 0, 20 );
			g.endFill();
			
			//mov.y = stage.stageHeight * .5;
			//M4Tween.createTween( mov, .5, { x: 300, y: 20, easing: Quad.easeOut } );
			//M4Tween.createTween( mov, .5, { x: 800, y: 500, easing: Quad.easeOut } );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onClick(e:MouseEvent):void 
		{
			M4Motion.createTween( mov, .5, { x: stage.mouseX, y: stage.mouseY, easing: Quad.easeOut } );
			//TweenLite.to( mov, .5, { x: stage.mouseX, y: stage.mouseY, ease: Quad.easeOut } );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function test():void
		{
			trace( "test ok" );
		}
		
		private function createBt():Sprite
		{
			var s:Sprite = new Sprite();			
			var g:Graphics = s.graphics;
			g.beginFill( 0x00ffff );
			g.drawRect( 0, 0, 100, 30 );
			g.endFill();
			
			return s;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}