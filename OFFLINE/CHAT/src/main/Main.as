
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
	import flash.utils.Timer;
	import fr.minuit4.net.Service;
	import fr.minuit4.net.stratus.StratusConnection;
	import fr.minuit4.net.stratus.StratusEvent;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _service:Service;
		private var _stratus:StratusConnection;
		
		private var _inited:Boolean;
		
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
			initNetwork();
		}
		
		private function onStratusConnection(e:StratusEvent):void 
		{
			_stratus.addOutPeer( "chat" );
			_service.call( "Users.getUserList", null, onUserListReady );
			_service.call( "Users.addUser", { id: _stratus.userID, pseudo: connectWindow.getPseudo() } );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initNetwork():void
		{
			_service = new Service( Config.amfUrl );
			
			_stratus = new StratusConnection( Config.devKey );
			_stratus.addEventListener( StratusEvent.CONNECTION_SUCCESS, onStratusConnection );
			_stratus.connect();
		}
		
		private function onUserListReady( list:Array ):void
		{
			if ( _inited )
			{
				
			}
			else
			{
				Config.userList = list;
				
				var i:int = list.length;
				while ( --i > -1 )
					_stratus.addInPeer( "chat", list[ i ].id );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}