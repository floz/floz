
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.Sprite;
	
	public class CustomMultiline extends Sprite implements IBrush
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _linesCount:int;
		private var _colors:Vector.<uint>;
		private var _deltaX:Vector.<Number>;
		private var _deltaY:Vector.<Number>;
		
		private var _lines:Vector.<Line>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function CustomMultiline( linesCount:int, deltaX:Vector.<Number>, deltaY:Vector.<Number>, colors:Vector.<uint> = null ) 
		{
			this._linesCount = linesCount;
			this._deltaX = deltaX;
			this._deltaY = deltaY;
			this._colors = colors;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var i:int;
			
			if ( !_colors )
			{
				_colors = new Vector.<uint>( _linesCount, true );
				i = _linesCount;
				while ( --i > -1 )
					_colors[ i ] = 0xff000000;
			}
			
			_lines = new Vector.<Line>( _linesCount, true );
			
			var n:int = _linesCount;
			for ( i = 0; i < n; ++i )
			{
				_lines[ i ] = new Line( _colors[ i ], _deltaX[ i ], _deltaY[ i ] );
				addChild( _lines[ i ] );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( mx:Number, my:Number ):void
		{
			var i:int = _linesCount;
			while ( --i > -1 )
				_lines[ i ].update( mx, my );
		}
		
		public function reset():void
		{
			var i:int = _linesCount;
			while ( --i > -1 )
				_lines[ i ].reset();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}