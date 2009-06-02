
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.lines.types 
{
	import flash.display.Sprite;
	import painting.interfaces.IBrush;
	
	public class Multiline extends Sprite implements IBrush
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Multiline() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function paint( mx:Number, my:Number ):void
		{
			var line:SimpleLine;
			
			var i:int = getLinesCount();
			while ( --i > -1 )
			{
				line = getChildAt( i ) as SimpleLine;
				line.paint( mx, my );
			}
		}
		
		public function completePainting():int
		{
			var line:SimpleLine;
			
			var count:int;
			
			var i:int = getLinesCount();
			while ( --i > -1 )
			{
				line = getChildAt( i ) as SimpleLine;
				count += line.completePainting();
			}
			
			return count;
		}
		
		public function reset( mx:Number, my:Number ):void
		{
			var line:SimpleLine;
			
			var i:int = getLinesCount();
			while ( --i > -1 )
			{
				line = getChildAt( i ) as SimpleLine;
				line.reset( mx, my );
			}
		}
		
		public function addLine( line:SimpleLine ):void
		{
			addChild( line );
		}
		
		public function releaseLine( line:SimpleLine ):void
		{
			removeChild( line );
		}
		
		public function getLinesCount():int
		{
			return this.numChildren;
		}
		
		public function hasLine():Boolean
		{
			return this.numChildren ? true : false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}