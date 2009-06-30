
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import fr.minuit4.motion.M4Tween;
	
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
			
			M4Tween.createTween( mov, .5, { } );
			M4Tween.createTween( this, .2, { } );
			
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