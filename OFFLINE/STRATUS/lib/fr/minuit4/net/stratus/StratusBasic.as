
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
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
	
	public class StratusBasic 
	{
		// - CONSTS ----------------------------------------------------------------------
		
		public static const STRATUS_URL:String = "rtmfp://stratus.adobe.com";
		
		public static const CONNECT:String = "stratusconnection_connect";
		public static const CONNECTION_FAILED:String = "stratusconnection_failed";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _developerKey:String;
		protected var _dispatcher:EventDispatcher;
		private var _connectEvent:Event;
		protected var _netConnection:NetConnection;
		
		protected var _userID:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function StratusBasic( developerKey:String ) 
		{
			this._developerKey = developerKey;
			
			_dispatcher = new EventDispatcher();
			_connectEvent = new Event( StratusBasic.CONNECT );
			
			_netConnection = new NetConnection();
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		protected function onNetStatus( e:NetStatusEvent ):void
		{
			switch( e.info.code )
			{
				// NetConnection
				case NetConnectionCode.CONNECTION_SUCCESS: onConnectionSuccess(); break;
				case NetConnectionCode.CONNECTION_CLOSED: onConnectionClosed(); break;
				case NetConnectionCode.CONNECTION_FAILED: onConnectionFailed(); break;
				
				// NetStream
				case NetStreamCode.CONNECTION_SUCCESS: onStreamConnectionSuccess(); break;
				case NetStreamCode.CONNECTION_CLOSED: onStreamConnectionClosed(); break;
				case NetStreamCode.PLAY_START: onStreamPlayStart(); break;
				case NetStreamCode.PLAY_RESET: onStreamPlayReset(); break;
				case NetStreamCode.PUBLISH_START: onStreamPlayPublishStart(); break;
				
				default: trace( "NetStatusEvent non pris en charge : " + e.info.code ); break;
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function onConnectionSuccess():void
		{
			_userID = _netConnection.nearID;
			_dispatcher.dispatchEvent( _connectEvent );
		}
		
		protected function onConnectionClosed():void
		{
			// MUST BE OVERRIDED
		}
		
		protected function onConnectionFailed():void
		{
			// MUST BE OVERRIDED
		}
		
		protected function onStreamConnectionSuccess():void
		{
			// MUST BE OVERRIDED
		}
		
		protected function onStreamConnectionClosed():void
		{
			// MUST BE OVERRIDED
		}
		
		protected function onStreamPlayStart():void
		{
			// MUST BE OVERRIDED
		}
		
		protected function onStreamPlayReset():void
		{
			// MUST BE OVERRIDED
		}
		
		protected function onStreamPlayPublishStart():void
		{
			// MUST BE OVERRIDED
		}
		
		protected function getPeer( id:String = null ):NetStream
		{
			var ns:NetStream = id ? new NetStream( _netConnection, id ) : new NetStream( _netConnection, NetStream.DIRECT_CONNECTIONS );
			ns.addEventListener( NetStatusEvent.NET_STATUS, NetStream.DIRECT_CONNECTIONS;
			return ns;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function connect():void
		{
			if ( _netConnection.connected )
				return;
			
			_netConnection.connect( StratusBasic.STRATUS_URL + "/" + _developerKey );
		}
		
		public function addOutPeer():void
		{
			// MUST BE OVERRIDED
		}
		
		public function addInPeer():void
		{
			// MUST BE OVERRIDED
		}
		
		public function send():void
		{
			// MUST BE OVERRIDED
		}
		
		//
		
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
		{
			_dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void
		{
			_dispatcher.removeEventListener( type, listener, useCapture );
		}
		
		public function hasEventListener( type:String ):void
		{
			_dispatcher.hasEventListener( type );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get userID():String { return this._userID; }
		
	}
	
}