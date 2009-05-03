
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import fr.minuit4.net.Service;
	import fr.minuit4.net.stratus.StratusConnection;
	import fr.minuit4.net.stratus.StratusEvent;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _checkTimer:Timer;
		
		private var _service:Service;
		private var _stratus:StratusConnection;
		
		private var _inited:Boolean;
		
		private var _checkList:Dictionary;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var msgWindow:MsgWindow;
		public var msgBox:MsgBox;
		public var usersWindow:UsersWindow;
		public var connectWindow:ConnectWindow;		
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			connectWindow.addEventListener( Event.CONNECT, onAppliStart );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAppliStart(e:Event):void 
		{
			_checkTimer = new Timer( 1500, 1 );
			_checkTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onCheckTimerComplete );
			
			initNetwork();
		}
		
		private function onCheckTimerComplete(e:TimerEvent):void 
		{
			
		}
		
		private function onStratusConnection(e:StratusEvent):void 
		{
			_stratus.addOutPeer( Config.CHAT_CHANNEL );
			_stratus.addOutPeer( Config.CONFIRMATION_CHANNEL );
			defineStratusMethods();
			
			_service.call( "Users.getUserList", null, onUserListReady );
			_service.call( "Users.addUser", { id: _stratus.userID, pseudo: connectWindow.getPseudo() } );
			
			connectWindow.hide();
		}
		
		private function onStreamStart(e:StratusEvent):void 
		{
			trace( "nouveau : " + _stratus.getUsersIDByChannel( "chat" ).length );
			_service.call( "Users.getUserList", null, onUserListReady );
			_stratus.send( Config.CONFIRMATION_CHANNEL, "addNewcomer", { id: _stratus.userID, pseudo: connectWindow.getPseudo() } );
		}
		
		private function onStreamClosed(e:StratusEvent):void 
		{
			trace( "fermeture : " + _stratus.getUsersIDByChannel("chat").length );
			//_checkList = new Dictionary();
			//_checkTimer.reset();
			//_checkTimer.start();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initNetwork():void
		{
			_service = new Service( Config.amfUrl );
			
			_stratus = new StratusConnection( Config.devKey );
			_stratus.addEventListener( StratusEvent.CONNECTION_SUCCESS, onStratusConnection );
			_stratus.addEventListener( StratusEvent.STREAM_START, onStreamStart );
			_stratus.addEventListener( StratusEvent.STREAM_CLOSED, onStreamClosed );
			_stratus.connect();
		}
		
		private function defineStratusMethods():void
		{
			var confirmation:Object = { };
			confirmation.addNewcomer = addNewcomer;
			//confirmation.pingAnswer = pingAnswer;
			_stratus.setMethodsByChannel( Config.CONFIRMATION_CHANNEL, confirmation );
		}
		
		private function onUserListReady( list:Array ):void
		{
			var i:int;
			
			if ( _inited )
			{
				i = list.length;
				var j:int = Config.userListFromPhp.length;
				var j0:int = j;
				var b:Boolean
				while ( --i > -1 )
				{
					j = j0;
					b = false;
					while ( --j > -1 )
					{
						if ( list[ i ].id == Config.userListFromPhp[ j ].id ) b = true;
						if ( b ) continue;
					}
					if ( !b ) addInPeers( list[ i ].id );
				}
				Config.userListFromPhp = list;
			}
			else
			{
				_inited = true;
				Config.userListFromPhp = list;
				
				i = list.length;
				while ( --i > -1 )
					addInPeers( list[ i ].id );
			}
		}
		
		private function addInPeers( id:String ):void
		{
			_stratus.addInPeer( Config.CHAT_CHANNEL, id );
			_stratus.addInPeer( Config.CONFIRMATION_CHANNEL, id );
		}
		
		private function addNewcomer( datas:Object ):void
		{
			if ( Config.userConnected[ datas.id ] ) 
				return;
			
			Config.userConnected[ datas.id ] = datas.pseudo;
			Config.userList.push( { id: datas.id, pseudo: datas.pseudo } );
			
			usersWindow.refresh();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}