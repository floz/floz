
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.managers 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import fr.minuit4.net.loaders.types.DatasLoader;
	
	public class GatewayManager 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _instance:GatewayManager;
		private static var _allowInstanciation:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const STATUS_ACCEPTED:String = "accepted";
		public static const STATUS_REFUSED:String = "refused";
		public static const STATUS_WON:String = "won";
		
		public static var userName:String = "test123";
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GatewayManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, please use the getInstance method." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():GatewayManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new GatewayManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public function addAction( title:String, details:String, enddate:uint, sender:uint, targets:String, media:String ):void
		{
			// TODO
		}
		
		public function updateAction( actionId:uint, targetId:uint, status:String ):URLLoader
		{
			var variables:URLVariables = new URLVariables();
			//variables.
			
			var request:URLRequest = new URLRequest();
			request.method = "POST";
			//request.data = 
			var urlLoader:URLLoader = new URLLoader();
		}
		
		public function getLoaderAction( actionId:uint ):DatasLoader
		{
			return new DatasLoader( "http://elive.gobelins.spyesx.org/api/action/" + user + "/" + actionId );			
		}
		
		public function getLoaderUser( user:String ):DatasLoader
		{
			return new DatasLoader( "http://elive.gobelins.spyesx.org/api/user/" + user );
		}
		
		public function getLoaderElist( user:String, actionId:uint ):DatasLoader
		{
			return new DatasLoader( "http://elive.gobelins.spyesx.org/api/elist/" + user + "/" + actionId );
		}
		
		public function getLoaderElists( user:String ):DatasLoader
		{
			return new DatasLoader( "http://elive.gobelins.spyesx.org/api/elists/" + user );
		}
		
		public function getLoaderFriends( user:String ):DatasLoader
		{
			return new DatasLoader( "http://elive.gobelins.spyesx.org/api/friends/" + user );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}