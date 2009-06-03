
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.ribbons.type 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import painting.interfaces.IBrush;
	import painting.interfaces.IBrushCtrl;
	import painting.interfaces.IBrushHolder;
	
	public class MultiRibbon extends Sprite implements IBrushCtrl
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ribbonsDatas:Vector.<IBrush>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MultiRibbon() 
		{
			_ribbonsDatas = new Vector.<IBrush>();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function createInstance():void
		{
			var instance:RibbonsHolder = new RibbonsHolder();
			addChild( instance );
			
			var i:int;
			var n:int = _ribbonsDatas.length;
			for ( ; i < n; ++i )
				instance.addBrush( _ribbonsDatas[ i ] );
		}
		
		public function deleteInstance( instance:IBrushHolder ):void
		{
			removeChild( instance as DisplayObject );
		}
		
		public function update( mx:Number, my:Number ):int
		{
			var count:int;
			
			var i:int = numChildren;
			while ( --i > -1 )
			{
				if ( !numChildren ) break;
				
				count += ( getChildAt( i ) as IBrushHolder ).update( mx, my );
			}
			
			return count;
		}
		
		public function releaseBrushes( mx:Number, my:Number ):void
		{
			var i:int = numChildren;
			while ( --i > -1 )
				( getChildAt( i ) as IBrushHolder ).releaseBrushes( mx, my );
		}
		
		public function addBrush( brush:IBrush ):void
		{
			_ribbonsDatas.push( brush );
		}
		
		public function removeBrush( brush:IBrush ):void
		{
			if ( !hasBrush( brush ) ) return;
			_ribbonsDatas.splice( getBrushIndex( brush ), 1 );
		}
		
		public function getBrushIndex( brush:IBrush ):int
		{
			return _ribbonsDatas.indexOf( brush );
		}
		
		public function hasBrush( brush:IBrush ):Boolean
		{
			return _ribbonsDatas.indexOf( brush ) != -1;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}