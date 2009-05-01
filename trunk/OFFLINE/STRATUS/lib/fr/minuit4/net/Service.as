
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
		private var _dictResponders:Dictionary;
		private var _netConnection:NetConnection;
		private var _responder:Responder;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Service( url:String ) 
		{
			this._url = url;
			
			_dictResponders = new Dictionary();
			
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
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addResponder( success:Function, fail:Function, commandName:String ):void
		{
			var responder:Responder = new Responder( success, fail );
			_dictResponders[ commandName ] = responder;
		}
		
		public function call( commandName:String, params:Object = null ):void
		{
			if ( !_dictResponders[ commandName ] ) return;
			_netConnection.call( commandName, _dictResponders[ commandName ], params );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}