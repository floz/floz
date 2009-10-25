
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ething 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _thing:Ething;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_thing = new Ething();
			_thing.scaleX =
			_thing.scaleY = .7;
			_thing.x = 230;
			_thing.y = 130;
			addChild( _thing );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}