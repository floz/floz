
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.Sprite;
	
	public class MultiDuplicateLines extends Sprite implements IBrush
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _duplicateLinesCount:int;
		private var _linesCount:int;
		private var _spacing:Number;
		private var _inverted:Boolean;
		private var _invertedGradient:Boolean;
		private var _maxAlpha:Number;
		private var _deltaX:Number;
		private var _deltaY:Number;
		private var _colors:Vector.<uint>;
		
		private var _lines:Vector.<DuplicateLines>;
		
		private var _xAxe:Boolean;
		private var _yAxe:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MultiDuplicateLines( duplicateLinesCount:int, linesCount:int, spacing:Number, inverted:Boolean = false, invertedGradient:Boolean = false, maxAlpha:Number = 1, deltaX:Number = 0, deltaY:Number = 0, colors:Vector.<uint> = null ) 
		{
			this._duplicateLinesCount = duplicateLinesCount;
			this._linesCount = linesCount;
			this._spacing = spacing;
			this._inverted = inverted;
			this._invertedGradient = invertedGradient;
			this._maxAlpha = maxAlpha;
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
				_colors = new Vector.<uint>( _duplicateLinesCount, true );
				i = _duplicateLinesCount;
				while ( --i > -1 )
					_colors[ i ] = 0xff000000;
			}
			
			_lines = new Vector.<DuplicateLines>( _duplicateLinesCount, true );
			_lines[ 0 ] = new DuplicateLines( _colors[ 0 ], _linesCount, _spacing, _inverted, _invertedGradient, _maxAlpha );
			
			var mult:int;
			var n:int = _duplicateLinesCount;
			for ( i = 1; i < n; ++i )
			{
				mult = i % 2 ? -1 : 1;
				_lines[ i ] = new DuplicateLines( _colors[ i ], _linesCount, _spacing, _inverted, _invertedGradient, _maxAlpha, _deltaX * i * mult, _deltaY * i * mult );
				addChild( _lines[ i ] );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( mx:Number, my:Number ):void
		{
			var i:int = _duplicateLinesCount;
			while ( --i > -1 )
				_lines[ i ].update( mx, my );
		}
		
		public function reset():void
		{
			var i:int = _duplicateLinesCount;
			while ( --i > -1 )
				_lines[ i ].reset();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get xAxe():Boolean { return _xAxe; }
		
		public function set xAxe(value:Boolean):void 
		{
			_xAxe = value;
			var i:int = _duplicateLinesCount;
			while ( --i > -1 )
				_lines[ i ].xAxe = value;
		}
		
		public function get yAxe():Boolean { return _yAxe; }
		
		public function set yAxe(value:Boolean):void 
		{
			_yAxe = value;
			var i:int = _duplicateLinesCount;
			while ( --i > -1 )
				_lines[ i ].yAxe = value;
		}
		
	}
	
}