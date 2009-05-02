
/**
 * Written by :
 * @author Minuit4
 * www.minuit4.fr
 */
package fr.minuit4.net.stratus 
{
	import flash.events.NetStatusEvent;
	import flash.net.NetStream;
	
	public class StratusConnection extends StratusBasic
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _listInPeers:Vector.<Object>;
		private var _listOutPeers:Vector.<Object>;
		private var _listMethodsByChannel:Vector.<Object>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Crée un objet StratusConnection permettant de faire du PeerToPeer via flash.
		 * Le service Stratus utilise le protocole rtmfp en passant par le port UDP 1935 et plus hauts.
		 * @param	developerKey	String	La clé développeur nécessaire pour utiliser le service. Obtenable ici : http://labs.adobe.com/technologies/stratus/
		 */
		public function StratusConnection( developerKey:String ) 
		{
			super( developerKey );
			
			_listInPeers = new Vector.<Object>();
			_listOutPeers = new Vector.<Object>();
			_listMethodsByChannel = new Vector.<Object>();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/**
		 * Renvoie le NetStream lié à l'identifiant passé en paramètre.
		 * @param	id	String	L'identifiant du NetStream que l'on veut récupérer.
		 * @return	NetStream
		 */
		private function getPeerById( id:String ):NetStream
		{
			var i:int = _listInPeers.length;
			while ( --i > -1 )
				if ( _listInPeers[ i ].id == id ) return _listInPeers[ i ].netStream;
			
			return null;
		}
		
		/**
		 * Renvoie le NetStream diffuseur sur un channel.
		 * @param	channelName	Le nom du channel sur lequel le NetStream a été crée.
		 * @return	NetStream
		 */
		private function getOutPeerByChannel( channelName:String ):NetStream
		{
			var i:int = _listOutPeers.length;
			while ( --i > -1 )
				if ( _listOutPeers[ i ].channelName == channelName ) return _listOutPeers[ i ].netStream;
			
			return null;
		}
		
		/**
		 * Crée un historique des méthodes attribuées sur le channel passé en paramètre.
		 * Cet historique est utilisée pour l'attribution de méthodes lors de l'ajout d'un nouveau NetStream que l'on va écouter.
		 * @param	channelName	String	Le nom du channel.
		 * @param	methods	Les méthodes déclenchée lors de la réception de messages sur ce channel.
		 */
		private function setMethodsHistoric( channelName:String, methods:Object ):void
		{
			var i:int = _listMethodsByChannel.length;
			while ( --i > -1 )
				if ( _listMethodsByChannel[ i ].channelName == channelName && _listMethodsByChannel[ i ].methods == methods ) return;
			
			_listMethodsByChannel.push( { channelName: channelName, methods: methods } );
		}
		
		/**
		 * Renvoie les méthodes de comportement liées à un channel.
		 * @param	channelName	String	Le nom du channel.
		 * @return	Object	Les méthodes de comportement.
		 */
		private function getMethodsByChannelName( channelName:String ):Object
		{
			var i:int = _listMethodsByChannel.length;
			while ( --i > -1 )
				if ( _listMethodsByChannel[ i ].channelName == channelName ) return _listMethodsByChannel[ i ].methods;
			
			return null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Ajoute un NetStream récepteur sur un channel précis. 
		 * Ce NetStream correspond à une nouvelle connexion avec un utilisateur distant. Ainsi, son identifiant doit être passé en paramètre.
		 * @param	channelName	String	Le nom du channel qui va être écouté/joué.
		 * @param	id	String	L'identifiant de l'utilisateur à écouter.
		 */
		override public function addInPeer( channelName:String, id:String ):void 
		{
			if ( !_netConnection.connected ) 
				return;
			
			var ns:NetStream = getPeer( id );			
			ns.play( channelName );
			
			var methods:Object = getMethodsByChannelName( channelName )
			if ( methods ) ns.client = methods;
			
			_listInPeers.push( { channelName: channelName, netStream: ns, id: id } );
		}
		
		/**
		 * Ajoute un NetSream diffuseur sur un channel précis.
		 * @param	channelName	String	Le nom du channel sur lequel les messages seront envoyés.
		 */
		override public function addOutPeer( channelName:String ):void 
		{
			if ( !_netConnection.connected )
				return;
			
			var ns:NetStream = getPeer();		
			ns.publish( channelName );		
			
			_listOutPeers.push( { channelName: channelName, netStream: ns } );
		}
		
		/**
		 * Envoie des informations sur un channel précis.
		 * Les informations peuvent être de différents types mais doivent être liées
		 * @param	channelName	String	Le nom du channel sur lequel les informations vont être diffusées.
		 * @param	handlerName	String	L'identifiant de l'information, exemple : "media".
		 * 			Si une méthode "media" a été passée en paramètre précédemment via "setMethodsByChannel", celle ci sera déclenchée.
		 * @param	... args	Vars	Les différentes variables qui vont être passées en paramètre à la méthode appellée via l'écoute du channel.
		 */
		override public function send( channelName:String, handlerName:String, ... args ):void
		{
			var ns:NetStream = getOutPeerByChannel( channelName );
			if ( !ns ) return;
			ns.send( handlerName, args );
		}
		
		/**
		 * Définis les méthodes de comportement sur tous les utilisateurs d'un channel.
		 * @param	channelName	String	Le nom du channel.
		 * @param	methods	Object	Les méthodes de comportement.
		 */
		public function setMethodsByChannel( channelName:String, methods:Object ):void
		{
			var i:int = _listInPeers.length;
			while ( --i > -1 )
				if ( _listInPeers[ i ].channelName == channelName ) ( _listInPeers[ i ].netStream as NetStream ).client = methods;
			
			setMethodsHistoric( channelName, methods );
		}
		
		/**
		 * Réinitialise les informations des instances de NetSteam.
		 * @param	destroy	Boolean	Faux par défaut afin de réinitialiser les différentes listes de NetSream (peers).
		 */
		override public function clean( destroy:Boolean = false ):void
		{
			var i:int = _listInPeers.length;
			while ( --i > -1 ) _listInPeers[ i ].netStream.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			i = _listOutPeers.length;
			while ( --i > -1 ) _listOutPeers[ i ].netStream.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			if ( destroy )
			{
				_listInPeers = null;
				_listMethodsByChannel = null;
				_listOutPeers = null;
			}
			else
			{
				_listInPeers = new Vector.<Object>();
				_listOutPeers = new Vector.<Object>();
				_listMethodsByChannel = new Vector.<Object>(); 
			}
		}
		
		/** 
		 * Supprime toutes les informations liées aux NetStream & NetConnection afin de libérer la mémoire.
		 * Après l'appel de cette méthode, l'object StratusConnection sera inutilisable.
		 */
		override public function destroy():void
		{
			disconnect();			
			clean( true );		
			
			_netConnection = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}