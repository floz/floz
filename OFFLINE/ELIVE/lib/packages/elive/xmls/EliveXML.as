
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.xmls 
{
	import elive.core.users.User;
	
	public class EliveXML 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EliveXML() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function parseUser( user:XML ):User
		{
			return null;
		}
		
		public static function parseUsers( datas:XML ):Vector.<User>
		{
			var list:XMLList = datas.children().( localName() == "user" );
			var n:int = list.length();
			var users:Vector.<User> = new Vector.<User>( n, true );
			
			return null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}