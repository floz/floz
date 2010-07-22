package com.gobzlite.net.amfphp 
{
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	/**
	 * Send request to amfphp server
	 * 
	 * -----------
	 * + usage
	 * -----------
	 * 
	 * Amfphp.gateway = "http://www.mysite.com/amfphp/gateway.php";
	 * Amfphp.instance.addEventListener( AmfphpEvent.RESPONSE, onResponse );
	 * Amfphp.instance.callService( command:String, ...params:Array );
	 * 
	 * private function onResponse(e:AmfphpEvent):void
	 * {
	 * 		Amfphp.instance.removeEventListener( AmfphpEvent.RESPONSE, onResponse );
	 * 
	 * 		if( e.success ){
	 * 			trace( e.result );
	 * 			trace( e.xmlResult );
	 * 		} else {
	 * 			trace( "error" );
	 * 		}
	 * }
	 * 
	 * @version 0.2 : change to singleton system
	 * @version 0.1 : first implementation 
	 * 
	 * @author David Ronai
	 */
	public class Amfphp extends EventDispatcher
	{
		private static var _instance:Amfphp = new Amfphp();
		private static var _gateway:String;
		
		private var _connection:NetConnection;
		private var _responder:Responder;
		private var _result:Object;
		
		/**
		 * Private constructor
		 */
		public function Amfphp() 
		{
			if ( _instance )
				throw new Error("You can't create an instance of Amfphp");
			
			_gateway = "";
			_responder = new Responder(resultHandler, faultHandler);
			_connection = new NetConnection();
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		// Call a service
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		
		/**
		 * Call an amfphp service on server
		 * @param	command command to call 
		 * @param	...params variables to send
		 */
		public function callService( command:String, ...params:Array ):void 
		{
			if ( _gateway == "" ) {
				throw new Error("You should define a default gateway before connection");
				return;
			}
			
			if( _connection.connected ) {
				throw new Error("You should wait response before call a new service");
				return;
			}
			
			_connection.connect(_gateway);
			_connection.call.apply(null, [ command, _responder].concat(params));		
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		// Handlers
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		
		private function faultHandler( result:Object ):void
		{
			trace("There was a problem: " + result.code + " : " + result.description);
			throw new Error( "Connection error :" + result.description);
			_connection.close();
			dispatchEvent( new AmfphpEvent( AmfphpEvent.ERROR ) );
		}		
		private function resultHandler( result:Object ):void
		{
			_result = result;
			_connection.close();
			dispatchEvent( new AmfphpEvent( AmfphpEvent.RESULT, result ) );
		}
		
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		// Getters and Setters
		//xxxxxxxxxxxxxxxxxxxxxxxxx
		
		static public function get gateway():String { return _gateway; }		
		static public function set gateway(value:String):void 
		{
			_gateway = value;
		}
		
		static public function get instance():Amfphp { return _instance; }
		
	}

}