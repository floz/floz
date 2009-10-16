
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
		
		private var _stats:UserStats;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var id:int;
		public var name:String;
		public var location:String;
		public var points:int;
		public var url:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function User() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function config( id:int, name:String, location:String, points:int, url:String ):void
		{
			this.id = id;
			this.name = name;
			this.location = location;
			this.points = points;
			this.url = url;
		}
		
		public function setStats( stats:UserStats ):void
		{
			_stats = stats;
		}
		public function getStats():UserStats { return _stats; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}