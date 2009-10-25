
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.groups 
{
	import elive.core.users.User;
	
	public class Group 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _users:Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var id:int;
		public var name:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Group( id:int, name:String ) 
		{
			this.id = id;
			this.name = name;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setMembers( users:Array ):void
		{
			this._users = users;
		}
		public function getMembers():Array { return this._users; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}