
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ColorPanel extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const COLORS:/*uint*/Array = [ 0xac0208, 0x000099, 0x9f2b39, 0x177ac7, 0x127695, 0x000000, 0xff00ff, 0x644c9f, 0xe5df1f ];
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var currentColor:uint;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ColorPanel() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function clickHandler(e:MouseEvent):void 
		{
			currentColor = ColorSquare( e.currentTarget ).color;
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var cs:ColorSquare;
			
			var px:int;
			
			var n:int = COLORS.length;
			for ( var i:int; i < n; ++i )
			{
				cs = new ColorSquare( COLORS[ i ] );
				cs.x = px;
				cs.addEventListener( MouseEvent.CLICK, clickHandler );
				addChild( cs );
				
				px += cs.width + 5;
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}