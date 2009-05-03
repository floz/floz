
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
		
		private var _lagTimer:Timer;
		
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
			_lagTimer = new Timer( 200, 1 );
			_lagTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
			initNetwork();
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			refreshUserList();
		}
		
		private function onStratusConnection(e:StratusEvent):void 
		{
			_stratus.addOutPeer( Config.CHAT_CHANNEL );
			defineStratusMethods();
			
			_service.call( "Users.addUser", { id: _stratus.userID, pseudo: connectWindow.getPseudo() } );
			_service.call( "Users.getUserList", null, onUserListReady );
			
			connectWindow.hide();
			msgBox.addEventListener( Event.COMPLETE, onMsgComplete );
		}
		
		private function onMsgComplete(e:Event):void 
		{
			msgWindow.addText( "<" + connectWindow.getPseudo() + "> " + msgBox.getLastMessage() );
			_stratus.send( Config.CHAT_CHANNEL, "message", { from: connectWindow.getPseudo(), msg: msgBox.getLastMessage() } );
		}
		
		// Une connexion à un stream vient d'être établie
		private function onStreamSuccess(e:StratusEvent):void 
		{
			// Si une connexion avec l'utilisateur n'a pas déjà été établie, on la crée, en l'enregistrant.
			if ( !Config.userAsked[ e.id ] )
			{
				Config.userAsked[ e.id ] = true;
				_stratus.addInPeer( Config.CHAT_CHANNEL, e.id );
			}
			_service.call( "Users.getUserList", null, onUserListReady );			
		}
		
		private function onStreamClosed(e:StratusEvent):void 
		{
			_stratus.killPeer( e.netStream );
			_service.call( "Users.deleteUser", e.netStream.farID );
			refreshUserList();
		}
		
		private function onStreamStart(e:StratusEvent):void 
		{
			_lagTimer.reset();
			_lagTimer.start();
		}
		
		private function onStreamPublishStart(e:StratusEvent):void 
		{
			var v:Vector.<Object> = new Vector.<Object>( 1, true );
			v[ 0 ] = { id: _stratus.userID, pseudo: connectWindow.getPseudo() };
			usersWindow.refresh( v );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initNetwork():void
		{
			_service = new Service( Config.amfUrl );
			
			_stratus = new StratusConnection( Config.devKey );
			_stratus.addEventListener( StratusEvent.CONNECTION_SUCCESS, onStratusConnection );
			_stratus.addEventListener( StratusEvent.STREAM_SUCCESS, onStreamSuccess );
			_stratus.addEventListener( StratusEvent.STREAM_CLOSED, onStreamClosed );
			_stratus.addEventListener( StratusEvent.STREAM_START, onStreamStart );
			_stratus.addEventListener( StratusEvent.STREAM_PLAY_PUBLISH_START, onStreamPublishStart );
			_stratus.connect();
		}
		
		private function defineStratusMethods():void
		{
			var chatMethods:Object = { };
			chatMethods.message = addMessage;
			_stratus.setMethodsByChannel( Config.CHAT_CHANNEL, chatMethods );
		}
		
		private function addMessage( datas:Object ):void
		{
			var from:String = datas.from;
			var msg:String = datas.msg;
			
			msgWindow.addText( "<" + from + "> " + msg );
		}
		
		private function onUserListReady( list:Array ):void
		{			
			var i:int;
			if ( _inited )
			{
				i = list.length;
				while ( --i > -1 )
					Config.pseudoByID[ list[ i ].id ] = list[ i ].pseudo;
			}
			else
			{
				_inited = true;				
				i = list.length;
				while ( --i > -1 )
				{
					Config.userAsked[ list[ i ].id ] = true;
					Config.pseudoByID[ list[ i ].id ] = list[ i ].pseudo;
					_stratus.addInPeer( Config.CHAT_CHANNEL, list[ i ].id );					
				}
			}
		}
		
		private function refreshUserList():void
		{
			var v:Vector.<Object> = new Vector.<Object>();
			var list:Vector.<String> = _stratus.getUsersIDByChannel( Config.CHAT_CHANNEL );
			var n:int = list.length;
			v.push( { id: _stratus.userID, pseudo: connectWindow.getPseudo() } );
			for ( var i:int; i < n; ++i )
				v.push( { id: list[ i ], pseudo: Config.pseudoByID[ list[ i ] ] } );
			
			usersWindow.refresh( v );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}