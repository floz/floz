
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pool 
{
	
	public class PoolItem 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const GROWTH_RATE:int = 3;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _initialized:Boolean;
		
		private static var _availableInPool:int;
		private static var _currentItem:Item;
		private static var _firstItemInPool:Item;
		private static var _lastItemInPool:Item;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PoolItem() 
		{
			throw new Error( "use createItem" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private static function initialize():void
		{
			var pooledItem:Item = new Item();
			_lastItemInPool = pooledItem;
			
			var i:int = GROWTH_RATE;
			while ( --i > -1 )
			{
				pooledItem.next = _currentItem;
				_currentItem = pooledItem;
				if( i > 0 ) pooledItem = pooledItem.prev = new Item();
			}
			_firstItemInPool = _currentItem;
			
			_availableInPool = GROWTH_RATE;
			_initialized = true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function createItem( name:String ):Item
		{
			if ( !_initialized ) initialize();
			
			var pooledItem:Item;
			if ( !_availableInPool )
			{
				var oldLastItemInPool:Item = _lastItemInPool;
				pooledItem = new Item();
				_lastItemInPool = pooledItem;
				
				var i:int = GROWTH_RATE;
				while ( --i > -1 )
				{
					pooledItem.next = _currentItem;
					_currentItem = pooledItem;
					if ( i > 0 ) pooledItem = pooledItem.prev = new Item();
				}
				pooledItem.prev = oldLastItemInPool;
				oldLastItemInPool.next = pooledItem;
				
				_availableInPool = GROWTH_RATE;
			}
			
			pooledItem = _currentItem;
			_currentItem = pooledItem.next;
			--_availableInPool;
			
			pooledItem.name = name;
			
			return pooledItem;
		}
		
		public static function releaseItem( item:Item ):void
		{
			if ( item == _lastItemInPool )
			{
				trace( "_lastItemInPool" );
				_currentItem = _lastItemInPool;
				++_availableInPool;
				return;
			}
			else if ( item == _firstItemInPool )
			{
				var newFirstItem:Item = _firstItemInPool.next;
				newFirstItem.prev = null;			
				
				_firstItemInPool = newFirstItem;
			}
			else
			{		
				item.prev.next = item.next;
				item.next.prev = item.prev;
			}		
			
			item.reset();
			_lastItemInPool.next = item;
			item.prev = _lastItemInPool;
			_lastItemInPool = item;
			
			if ( !_currentItem ) _currentItem = _lastItemInPool;
			
			++_availableInPool;
		}
		
		public static function readPool():void
		{
			var item:Item = _firstItemInPool;
			while ( item )
			{
				trace( item.name + ( item == _currentItem ? " - CURRENT ITEM" : "" ));
				item = item.next;				
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}