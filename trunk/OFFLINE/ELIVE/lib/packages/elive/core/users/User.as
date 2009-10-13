
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.users 
{
	
	public class User 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _id:uint;
		private var _name:String;
		private var _location:String;
		private var _points:uint;
		private var _url:String;
		private var _stats:UserStats;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function User() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function setId( value:uint ):void
		{
			_id = value;
		}
		public function getId():uint { return _id; }
		
		public function setName( value:String ):void
		{
			_name = value;
		}
		public function getName():String { return _name; }
		
		public function setLocation( value:String ):void
		{
			_location = value;
		}
		public function getLocation():String { return _location; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}