
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	
	public class PooledCircle 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const GROWTH_RATE:int = 0x10;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _allowInstanciation:Boolean;
		private var _availableInPool:int;
		private var _currentPooledCircle:PooledCircle;
		
		private var _next:PooledCircle;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PooledCircle() 
		{
			if ( !_allowInstanciation )
				throw new Error( "This class can't be instanciated, you have to use the create method." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function create():PooledCircle
		{
			var pooledCircle:PooledCircle;
			
			if ( !_availableInPool )
			{
				var i:int = GROWTH_RATE;
				while ( --i > -1 )
				{
					_allowInstanciation = true; {
						pooledCircle = new PooledCircle();
					} _allowInstanciation = false;
					
					pooledCircle._next = _currentPooledCircle;
					_currentPooledCircle = pooledCircle;
				}
				
				_availableInPool = GROWTH_RATE;
			}
			
			pooledCircle = _currentPooledCircle;
			_currentPooledCircle = pooledCircle._next;
			
			--_availableInPool;
			
			return pooledCircle;
		}
		
		public static function release( pooledCircle:PooledCircle ):void
		{
			pooledCircle._next = _currentPooledCircle;
			_currentPooledCircle = pooledCircle;
			
			++_availableInPool;
		}
		
		public function dispose():void
		{
			release( this );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}