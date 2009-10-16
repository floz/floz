
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	import flash.events.EventDispatcher;
	
	public class NavManager extends EventDispatcher
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:NavManager;
		
		private var _items:Object;
		private var _itemsModels:Vector.<ItemModel>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NavManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use getInstance method instead." );
			
			_items = { };
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():NavManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new NavManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public function parseNav( datas:XML ):void
		{
			var itemModel:ItemModel;
			
			var n:int = datas.rub.length();
			_itemsModels = new Vector.<ItemModel>( n, true );
			
			var x:XML;
			for ( var i:int; i < n; ++i )
			{
				x = datas.rub[ i ];
				_itemsModels[ i ] = itemModel = new ItemModel( x.id, x.title, x.url, x.icon );
				_items[ itemModel.id ] = itemModel.url;
			}
		}
		
		public function switchRub( rubId:String ):void
		{
			
		}
		
		public function getItemsModel():Vector.<ItemModel> { return this._itemsModels; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}