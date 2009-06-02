
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.ribbons.type 
{
	import flash.display.Sprite;
	import painting.interfaces.IBrush;
	
	public class MultiRibbon extends Sprite implements IBrush
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MultiRibbon() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function paint( mx:Number, my:Number ):void
		{
			var ribbon:SimpleRibbon;
			
			var i:int = getRibbonsCount();
			while ( --i > -1 )
			{
				ribbon = getChildAt( i ) as SimpleRibbon;
				ribbon.paint( mx, my );
			}
		}
		
		public function completePainting():int
		{
			var ribbon:SimpleRibbon;
			
			var count:int;
			
			var i:int = getRibbonsCount();
			while ( --i > -1 )
			{
				ribbon = getChildAt( i ) as SimpleRibbon;
				count += ribbon.completePainting();
			}
			
			return count;
		}
		
		public function reset( mx:Number, my:Number ):void
		{
			var ribbon:SimpleRibbon;
			
			var i:int = getRibbonsCount();
			while ( --i > -1 )
			{
				ribbon = getChildAt( i ) as SimpleRibbon;
				ribbon.reset( mx, my );
			}
		}
		
		public function addRibbon( ribbon:SimpleRibbon ):void
		{
			addChild( ribbon );
		}
		
		public function releaseRibbon( ribbon:SimpleRibbon ):void
		{
			removeChild( ribbon );
		}
		
		public function getRibbonsCount():int
		{
			return this.numChildren;
		}
		
		public function hasRibbon():Boolean
		{
			return this.numChildren ? true : false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}