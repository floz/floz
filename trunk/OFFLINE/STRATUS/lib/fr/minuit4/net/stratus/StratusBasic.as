
/**
 * Written by :
 * @author Minuit4
 * www.minuit4.fr
 */
package fr.minuit4.net.stratus 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import fr.minuit4.net.code.NetConnectionCode;
	import fr.minuit4.net.code.NetStreamCode;
	
	public class StratusBasic 
	{
		// - CONSTS ----------------------------------------------------------------------
		
		public static const STRATUS_URL:String = "rtmfp://stratus.adobe.com";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _developerKey:String;
		protected var _dispatcher:EventDispatcher;
		private var _connectionSuccessEvent:StratusEvent;
		private var _connectionFailedEvent:StratusEvent;
		private var _connectionClosedEvent:StratusEvent;
		private var _streamSuccessEvent:StratusEvent;
		private var _streamStartEvent:StratusEvent;
		private var _streamResetEvent:StratusEvent;
		private var _streamPublishStartEvent:StratusEvent;
		private var _streamClosedEvent:StratusEvent;
		protected var _netConnection:NetConnection;
		
		protected var _userID:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function StratusBasic( developerKey:String ) 
		{
			this._developerKey = developerKey;
			
			_dispatcher = new EventDispatcher();
			_connectionSuccessEvent = new StratusEvent( StratusEvent.CONNECTION_SUCCESS );
			_connectionFailedEvent = new StratusEvent( StratusEvent.CONNECTION_FAILED );
			_connectionClosedEvent = new StratusEvent( StratusEvent.CONNECTION_CLOSED );
			_streamSuccessEvent = new StratusEvent( StratusEvent.STREAM_SUCCESS );
			_streamStartEvent = new StratusEvent( StratusEvent.STREAM_START );
			_streamResetEvent = new StratusEvent( StratusEvent.STREAM_RESET );
			_streamPublishStartEvent = new StratusEvent( StratusEvent.STREAM_PLAY_PUBLISH_START );			
			_streamClosedEvent = new StratusEvent( StratusEvent.STREAM_CLOSED );
			
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
			_dispatcher.dispatchEvent( _connectionSuccessEvent );
		}
		
		protected function onConnectionClosed():void
		{
			trace( "StratusBasic.onConnectionClosed" );
			_dispatcher.dispatchEvent( _connectionClosedEvent );
			
			// MUST BE OVERRIDED
		}
		
		protected function onConnectionFailed():void
		{
			trace( "StratusBasic.onConnectionFailed" );
			_dispatcher.dispatchEvent( _connectionFailedEvent );
			
			// MUST BE OVERRIDED
		}
		
		protected function onStreamConnectionSuccess():void
		{
			trace( "StratusBasic.onStreamConnectionSuccess" );
			_dispatcher.dispatchEvent( _streamSuccessEvent );
			// MUST BE OVERRIDED
		}
		
		protected function onStreamConnectionClosed():void
		{
			trace( "StratusBasic.onStreamConnectionClosed" );
			_dispatcher.dispatchEvent( _streamClosedEvent );
			
			// MUST BE OVERRIDED
		}
		
		protected function onStreamPlayStart():void
		{
			trace( "StratusBasic.onStreamPlayStart" );
			trace( _netConnection.farID );
			_dispatcher.dispatchEvent( _streamStartEvent );
			
			// MUST BE OVERRIDED
		}
		
		protected function onStreamPlayReset():void
		{
			trace( "StratusBasic.onStreamPlayReset" );
			_dispatcher.dispatchEvent( _streamResetEvent );
			
			// MUST BE OVERRIDED
		}
		
		protected function onStreamPlayPublishStart():void
		{
			trace( "StratusBasic.onStreamPlayPublishStart" );
			_dispatcher.dispatchEvent( _streamPublishStartEvent );
			// MUST BE OVERRIDED
		}
		
		/**
		 * Renvoie un NetSream entrant (récepteur) ou sortant (diffuseur).
		 * Si le paramètre id est nul, un NetStream sortant sera crée, et vice et versa.
		 * @param	id	String	L'identifiant correspondant à un utilisateur distant.
		 * @return
		 */
		protected function getPeer( id:String = null ):NetStream
		{
			var ns:NetStream = id ? new NetStream( _netConnection, id ) : new NetStream( _netConnection, NetStream.DIRECT_CONNECTIONS );
			ns.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			if ( !ns ) throw new Error( "StratusBasic.getPeer() : Le NetStream n'a pas pu être instancié correctement." + id );
			
			return ns;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/** Débute la connection avec le service stratus */
		public function connect():void
		{
			if ( _netConnection.connected )
				return;
			
			_netConnection.connect( StratusBasic.STRATUS_URL + "/" + _developerKey );
		}
		
		/** 
		 * Met fin à la connection avec le service stratus.
		 * Attention les références aux différentes instances de NetStream créée ne sont pas supprimées.
		 * Pour se faire, veuillez appeller la méthode clean();
		 */
		public function disconnect():void
		{
			if ( !_netConnection.connected )
				return;
			
			try { _netConnection.close() }
			catch ( e:Error ) { trace( "netConnection.close() impossible !" ) };			
		}
		
		/**
		 * Réinitialise les informations des instances de NetSteam.
		 * @param	destroy	Boolean	Faux par défaut afin de réinitialiser les différentes listes de NetSream (peers).
		 */
		public function clean( destroy:Boolean = false ):void
		{
			// MUST BE OVERRIDED
		}
		
		/** 
		 * Supprime toutes les informations liées aux NetStream & NetConnection afin de libérer la mémoire.
		 * Après l'appel de cette méthode, l'object StratusConnection sera inutilisable.
		 */
		public function destroy():void
		{
			// MUST BE OVERRIDED
		}
		
		/**
		 * Ajoute un NetStream récepteur sur un channel précis. 
		 * Ce NetStream correspond à une nouvelle connexion avec un utilisateur distant. Ainsi, son identifiant doit être passé en paramètre.
		 * @param	channelName	String	Le nom du channel qui va être écouté/joué.
		 * @param	id	String	L'identifiant de l'utilisateur à écouter.
		 */
		public function addInPeer( channelName:String, id:String ):void
		{
			// MUST BE OVERRIDED
		}
		
		/**
		 * Ajoute un NetSream diffuseur sur un channel précis.
		 * @param	channelName	String	Le nom du channel sur lequel les messages seront envoyés.
		 */
		public function addOutPeer( channelName:String ):void
		{
			// MUST BE OVERRIDED
		}
		
		/**
		 * Ajoute un NetStream diffuseur et récepteur.
		 * @param	channelName	String	Le nom du channel sur lequel les échanges vont s'effectueur.
		 * @param	id	String	L'identifiant de l'utilisateur à écouter.
		 */
		public function addPeers( channelName:String, id:String ):void
		{
			addOutPeer( channelName );
			addInPeer( channelName, id );
		}
		
		/**
		 * Envoie des informations sur un channel précis.
		 * Les informations peuvent être de différents types mais doivent être liées
		 * @param	channelName
		 * @param	handlerName
		 * @param	... args
		 */
		public function send( channelName:String, handlerName:String, ... args ):void
		{
			// MUST BE OVERRIDED
		}
		
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
		
		/** Permet de récupérer l'identifiant lié à la connexion en cours, renvoyé par le service Stratus */
		public function get userID():String { return this._userID; }
		
	}
	
}