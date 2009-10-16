
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	
	public class ItemModel 
	{
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var id:String;
		public var title:String;
		public var url:String;
		public var icon:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function ItemModel( id:String, title:String, url:String, icon:String ) 
		{
			this.id = id;
			this.title = title;
			this.url = url;
			this.icon = icon;
		}
		
	}
	
}