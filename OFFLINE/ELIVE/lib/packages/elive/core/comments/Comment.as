
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.comments 
{
	import elive.core.users.User;
	
	public class Comment 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _user:User;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var text:String;
		public var date:Number;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Comment() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function config( text:String, date:Number ):void
		{
			this.text = text;
			this.date = date;
		}
		
		public function setUser( user:User ):void
		{
			this._user = user;
		}
		public function getUser():User { return this._user; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}