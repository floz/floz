
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
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
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function StratusConnection( developerKey:String ) 
		{
			super( developerKey );
			
			_listInPeers = new Vector.<Object>(1337);
			_listOutPeers = new Vector.<Object>(1337);
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getOutPeerByChannel( channelName:Stirng ):NetStream
		{
			var i:int = _listOutPeers.length;
			while ( --i > -1 )
				if ( _listOutPeers[ i ].channelName == channelName ) return _listOutPeers[ i ].netStream;
			
			return null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		override public function addInPeer( channelName:String, id:String ):void 
		{
			if ( !_netConnection.connected ) 
				return;
			
			var ns:NetStream = getPeer( id );
			ns.play( channelName );
			
			_listInPeers.push( { channelName: channelName, netStream: ns } );
		}
		
		override public function addOutPeer( channelName:String ):void 
		{
			if ( !_netConnection.connected )
				return;
			
			var ns:NetStream = getPeer();
			ns.publish( channelName );
			
			_listOutPeers.push( { channelName: channelName, netStream: ns } );
		}
		
		public function addPeers( channelName:String, id:String ):void
		{
			addOutPeer( channelName );
			addInPeer( channelName, id );
		}
		
		public function getMethodsOnPeerChannel( channelName:String ):Object
		{
			var ns:NetStream = getOutPeerByChannel( channelName );
			return ns ? ns.client : null;
		}
		
		public function setMethodsOnPeerChannel( channelName:String, methods:Object ):void
		{
			var ns:NetStream = getOutPeerByChannel( channelName );
			ns.client = methods;
		}
		
		override public function send( channelName:String, handlerName:String, ... args ):void
		{
			var ns:NetStream = getOutPeerByChannel( channelName );
			if ( !ns ) 
				return;
			
			ns.send( handlerName, args );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}