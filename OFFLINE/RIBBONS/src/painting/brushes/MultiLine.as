
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.Sprite;
	
	public class MultiLine extends Sprite implements IBrush
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _linesCount:int;
		private var _colors:Vector.<uint>;
		private var _deltaX:Number;
		private var _deltaY:Number;
		
		private var _lines:Vector.<Line>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MultiLine( linesCount:int, deltaX:Number = 0, deltaY:Number = 0, colors:Vector.<uint> = null ) 
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
			_lines[ 0 ] = new Line( _colors[ 0 ] );
			
			var mult:int;
			var n:int = _linesCount;
			for ( i = 1; i < n; ++i )
			{
				mult = i % 2 ? -1 : 1;
				_lines[ i ] = new Line( _colors[ i ], _deltaX * i * mult, _deltaY * i * mult );
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