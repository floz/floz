
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.net.stratus 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import fr.minuit4.net.NetConnectionCode;
	import fr.minuit4.net.NetStreamCode;
	
	public class StratusConnection extends EventDispatcher
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static const STRATUS_URL:String = "rtmfp://stratus.adobe.com";
		
		public static const CONNECT:String = "stratusconnection_connect";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _developerKey:String;
		private var _streamName:String;
		private var _connectEvent:Event;
		private var _netConnection:NetConnection;
		
		private var _userId:String;
		
		private var _sendStream:NetStream;		
		private var _receiveStream:NetStream;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function StratusConnection( developerKey:String, streamName:String = "minuit4_transaction" ) 
		{
			this._developerKey = developerKey;
			this._streamName = streamName
			
			_connectEvent = new Event( StratusConnection.CONNECT );
			
			_netConnection = new NetConnection();
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onNetStatus(e:NetStatusEvent):void 
		{
			switch( e.info.code )
			{
				case NetConnectionCode.CONNECTION_SUCCESS :
					_userId = _netConnection.nearID;
					addUserPeer();
					
					dispatchEvent( _connectEvent );
					break;
				case NetConnectionCode.CONNECTION_FAILED :
					trace( NetConnectionCode.CONNECTION_FAILED );
					break;
				case NetConnectionCode.CONNECTION_CLOSED :
					trace( NetConnectionCode.CONNECTION_CLOSED );
					break;
				case NetStreamCode.PLAY_START :
					trace( NetStreamCode.PLAY_START );
					break;
				case NetStreamCode.CONNECTION_SUCCESS :
					trace( NetStreamCode.CONNECTION_SUCCESS );
					break;
				case NetStreamCode.CONNECTION_CLOSED :
					trace( NetStreamCode.CONNECTION_CLOSED );
					break;
				case NetStreamCode.PLAY_RESET :
					trace( NetStreamCode.PLAY_RESET );
					break;
				default:
					trace( "NetStatusEvent non pris en charge : " + e.info.code );
					break;
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function addUserPeer():void
		{
			_sendStream = new NetStream( _netConnection, NetStream.DIRECT_CONNECTIONS );
			_sendStream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			_sendStream.publish( _streamName );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function connect():void
		{
			if ( _netConnection.connected ) 
				return;
			
			_netConnection.connect( StratusConnection.STRATUS_URL + "/" + _developerKey );
		}
		
		public function addPeer( id:String ):void
		{
			_receiveStream = new NetStream( _netConnection, id );
			_receiveStream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			_receiveStream.play( _streamName );
		}
		
		public function send( handlerName:String, params:* ):void
		{
			_sendStream.send( handlerName, params );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get userId():String { return this._userId; }
		
	}
	
}