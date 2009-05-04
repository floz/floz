
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.utils.Dictionary;
	
	public class Config 
	{
		public static const devKey:String = "76418ac5f3689170bce4fbed-d76819ed40c7";
		public static const amfUrl:String = "http://floz.fr/amfphp/gateway.php";
		
		public static const CONFIRMATION_CHANNEL:String = "confirmation";
		public static const CHAT_CHANNEL:String = "chat";
		
		public static const MODO:String = "moderateur";
		public static const USER:String = "user";
		
		public static var type:String;
		
		public static const userAsked:Dictionary = new Dictionary();		
		public static const pseudoByID:Dictionary = new Dictionary();
	}
	
}