
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	
	public class NavManager
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:NavManager;
		
		private var _items:Object;
		
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
			
			var x:XML;
			for each( x in datas.rub )
			{
				itemModel = new ItemModel();
				itemModel.id = x.id;
				itemModel.title = x.title;
				itemModel.url = x.url;
				itemModel.icon = x.icon;
				
				_items[ itemModel.id ] = itemModel.url;
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}