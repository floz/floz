
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.lines 
{
	import flash.display.Shape;
	import flash.utils.getQualifiedClassName;
	
	public class PooledLine extends Shape
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static const POOL_GROWTH_RATE:int = 0x14;
		
		private static var _availableInPool:int;
		private static var _pool:PooledLine;
		private static var _allowInstance:Boolean;
		
		private var _nextInPool:PooledLine;
		
		private var _colors:Vector.<uint>;
		private var _alphas:Vector.<Number>;		
		private var _colorsCount:int;
		private var _alphasCount:int;
		private var _colorsIdx:int;
		private var _alphasIdx:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var px:Number;
		public var py:Number;
		public var vx:Number;
		public var vy:Number;
		public var dx:Number;
		public var dy:Number;	
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PooledLine() 
		{
			verifyInstanciation();
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function verifyInstanciation():void
		{
			if ( !_allowInstance ) 
				throw new Error( getQualifiedClassName( PooledLine ) + "is a pooled class. Use the static create() method instead" );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function create( colors:Vector.<uint>, alphas:Vector.<Number> ):PooledLine
		{
			var pooledLine:PooledLine;
			
			if ( !_availableInPool )
			{
				var n:int = POOL_GROWTH_RATE;
				while ( --n > -1 )
				{
					_allowInstance = true;
					pooledLine = new PooledLine();
					_allowInstance = false;
					
					pooledLine._nextInPool = _pool;
					_pool = pooledLine;
				}
				
				_availableInPool += POOL_GROWTH_RATE;
			}
			
			pooledLine = _pool;
			_pool = pooledLine._nextInPool;
			--_availableInPool;
			
			pooledLine.vx =
			pooledLine.vy = 0;
			
			pooledLine.px =
			pooledLine.py =
			pooledLine.dx =
			pooledLine.dy = NaN;
			
			pooledLine.colors = colors;
			pooledLine.alphas = alphas;
			
			return pooledLine;
		}
		
		public static function release( pooledLine:PooledLine ):void
		{
			pooledLine._nextInPool = _pool;
			_pool = pooledLine;
			
			++_availableInPool;
		}
		
		public function dispose():void
		{
			release( this );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get alphas():Vector.<Number> { return _alphas; }
		
		public function set alphas(value:Vector.<Number>):void 
		{
			_alphas = value;
			_alphasCount = _alphas.length;
			_alphasIdx = 0;
		}
		
		public function get colors():Vector.<uint> { return _colors; }
		
		public function set colors(value:Vector.<uint>):void 
		{
			_colors = value;
			_colorsCount = _colors.length;
			_colorsIdx = 0;
		}
		
		public function get colorsIdx():int { return _colorsIdx; }
		
		public function set colorsIdx(value:int):void 
		{
			if ( value < 0 ) _colorsIdx = int( _colorsCount - 1 );
			else if ( value > int( _colorsCount - 1 ) ) _colorsIdx = 0;
			else _colorsIdx = value;
		}
		
		public function get alphasIdx():int { return _alphasIdx; }
		
		public function set alphasIdx(value:int):void 
		{
			if ( value < 0 ) _alphasIdx = int( _alphasCount - 1 );
			else if ( value > int( _alphasCount - 1 ) ) _alphasIdx = 0;
			else _alphasIdx = value;			
		}
		
	}
	
}