
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.Sprite;
	
	public class MultiRibbons extends Sprite implements IBrush
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _linesCount:int;
		private var _deltaX:Number;
		private var _deltaY:Number;
		private var _colors:Vector.<Array>;
		private var _alphas:Vector.<Array>;
		
		private var _ribbons:Vector.<Ribbon>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MultiRibbons( linesCount:int, deltaX:Number = 0, deltaY:Number = 0, colors:Vector.<Array> = null, alphas:Vector.<Array> = null ) 
		{
			this._linesCount = linesCount;
			this._deltaX = deltaX;
			this._deltaY = deltaY;
			this._colors = colors;
			this._alphas = alphas;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var i:int;
			
			if ( !_colors )
			{
				_colors = new Vector.<Array>( _linesCount, true );
				i = _linesCount;
				while ( --i > -1 )
					_colors[ i ] = [ 0xff000000 ];
			}
			
			_ribbons = new Vector.<Ribbon>( _linesCount, true );
			_ribbons[ 0 ] = new Ribbon( _colors[ 0 ], _alphas[ 0 ], true );
			addChild( _ribbons[ 0 ] );
			
			var mult:int;
			var n:int = _linesCount;
			for ( i = 1; i < n; ++i )
			{
				mult = i % 2 ? -1 : 1;
				_ribbons[ i ] = new Ribbon( _colors[ i ], _alphas[ i ], true, _deltaX * i * mult, _deltaY * i * mult );
				addChild( _ribbons[ i ] );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( mx:Number, my:Number ):void
		{
			var i:int = _linesCount;
			while ( --i > -1 )
				_ribbons[ i ].update( mx, my );
		}
		
		public function reset():void
		{
			var i:int = _linesCount;
			while ( --i > -1 )
				_ribbons[ i ].reset();
		}
		
		public function setColors():void
		{
			
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}