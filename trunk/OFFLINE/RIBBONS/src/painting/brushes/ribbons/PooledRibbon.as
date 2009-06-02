
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.ribbons 
{
	import flash.display.Shape;
	import flash.utils.getQualifiedClassName;
	
	public class PooledRibbon extends Shape
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static const POOL_GROWTH_RATE:int = 0x14;
		
		private static var _availableInPool:int;
		private static var _pool:PooledRibbon;
		private static var _allowInstance:Boolean;
		
		private var _nextInPool:PooledRibbon;
		
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
		
		public var x1:Number;
		public var y1:Number;
		public var x2:Number;
		public var y2:Number;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PooledRibbon() 
		{
			verifyInstanciation();
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function verifyInstanciation():void
		{
			if( !_allowInstance ) throw new Error( getQualifiedClassName( PooledRibbon ) + "is a pooled class. Use the static create() method instead" );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		static public function create( colors:Vector.<uint>, alphas:Vector.<Number> ):PooledRibbon
		{
			var pooledRibbon:PooledRibbon;
			
			if ( !_availableInPool )
			{
				var n:int = POOL_GROWTH_RATE;
				while ( --n > -1 )
				{
					_allowInstance = true;
					pooledRibbon = new PooledRibbon();
					_allowInstance = false;
					
					pooledRibbon._nextInPool = _pool;
					_pool = pooledRibbon;
				}
				_availableInPool += POOL_GROWTH_RATE;
			}
			
			pooledRibbon = _pool;
			_pool = pooledRibbon._nextInPool;
			--_availableInPool;
			
			pooledRibbon.x1 =
			pooledRibbon.y1 =
			pooledRibbon.x2 =
			pooledRibbon.y2 =
			pooledRibbon.dx =
			pooledRibbon.dy =
			pooledRibbon.px =
			pooledRibbon.py = NaN;
			
			pooledRibbon.vx = 
			pooledRibbon.vy = 0;
			
			pooledRibbon.colors = colors;
			pooledRibbon.alphas = alphas;
			
			return pooledRibbon;
		}
		
		static public function release( pooledRibbon:PooledRibbon ):void
		{
			pooledRibbon._nextInPool = _pool;
			_pool = pooledRibbon;
			
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