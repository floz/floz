
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package poolArray 
{
	import caurina.transitions.Tweener;
	
	public class PoolArrayItem 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static const GROWTH_RATE:int = 5;
		
		private static var _count:int;
		private static var _pool:Array;
		private static var _initialized:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PoolArrayItem() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function initialize():void
		{
			_pool = [];
			
			var i:int = GROWTH_RATE;
			while ( --i > -1 )
				_pool[ i ] = new ItemArray();
			
			_count = GROWTH_RATE;
			
			_initialized = true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function create( name:String ):ItemArray
		{
			if ( !_initialized ) initialize();
			
			if ( !_count )
			{
				var i:int = GROWTH_RATE;
				
				while ( --i > -1 )
					_pool.unshift( new ItemArray() );
				
				_count = GROWTH_RATE;
			}
			
			var item:ItemArray = _pool[ --_count ];
			item.name = name;
			
			return item;
		}
		
		public static function release( item:ItemArray ):void
		{
			var idx:int = _pool.indexOf( item );
			_pool.unshift( _pool.splice( idx, 1 )[0] );
			++_count;
			
			item.name += " - free";
		}
		
		public static function readPool():void
		{
			var n:int = _pool.length;
			for ( var i:int; i < n; ++i )
			{
				var item:ItemArray = _pool[ i ];
				
				trace( i.toString() + " - " + item.name + ( i == _count ? " - COUNT" : "" ) );
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}