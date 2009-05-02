
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.net 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.Dictionary;
	import fr.minuit4.net.code.NetConnectionCode;
	
	public class Service 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _url:String;
		private var _netConnection:NetConnection;
		private var _responder:Responder;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Service( url:String ) 
		{
			this._url = url;
			
			_netConnection = new NetConnection();
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			_netConnection.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			_netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, onAsynErrorEvent );
			_netConnection.connect( url );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			trace( "Service.onNetStatus > e : " + e );
			trace( e.info.code );
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "Service.onIOError > " + _url );			
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void 
		{
			trace( "Service.onSecurityError > e : " + e );			
		}
		
		private function onAsynErrorEvent(e:AsyncErrorEvent):void 
		{
			trace( "Service.onAsynErrorEvent > e : " + e );			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function onSuccess( values:* ):void
		{
			// trace( values );
		}
		
		private function onFail( values:* ):void
		{
			for ( var error:String in values )
				trace( error + " : " + values[ error ] );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function call( commandName:String, params:Object = null, success:Function = null, fail:Function = null ):void
		{
			var responder:Responder = new Responder( success is Function ? success : onSuccess, fail is Function ? fail : onFail );
			_netConnection.call( commandName, responder, params );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}