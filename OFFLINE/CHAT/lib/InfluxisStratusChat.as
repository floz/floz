package {
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.motion.Color;
	import flash.net.SharedObject;
	import flash.geom.ColorTransform;
	import fl.motion.easing.*;
	import flash.utils.Timer;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.SyncEvent;
	import flash.net.Responder;
	import flash.utils.getDefinitionByName;
	
	public class InfluxisStratusChat extends MovieClip{
		
		private var rtmpGo:String = "rtmfp://stratus.adobe.com"; 
		private var stratusGo:String = "rtmfp://stratus.adobe.com";
		private var devKey:String = "76418ac5f3689170bce4fbed-d76819ed40c7";
		private var nc:NetConnection;
		private var nc1:NetConnection;
		private var inNS:NetStream;
		private var outNS:NetStream;
		private var listenerStream:NetStream;
		private var controlNS:NetStream;
		public var so:SharedObject;
		private var myName:String;
		private var recNS:NetStream;
		private var fms:Boolean = false;
		private var stratus:Boolean = false;
		private var firstOne:Boolean = false;
		private var secondary:Boolean = false;
		public var id:String = null;
		public var idA:Array;
		public var incomingStreams:Array;
		public var names:Array;
		public var stratusCounter:Number = 0;
		
		public function InfluxisStratusChat(){
			initFMS();
			initStratus();
			
			nameSplash.chatButt.addEventListener(MouseEvent.CLICK, enterChat);
			nameSplash.warning.mouseChildren = false;
			
			addEventListener(Event.ENTER_FRAME, checker);
		}
		
		private function initFMS():void{ 
            nc1 = new NetConnection( ); 
            nc1.connect (rtmpGo); 
			nc1.addEventListener (NetStatusEvent.NET_STATUS, fmsNCStatus);
		}
		
		private function fmsNCStatus( p_e:NetStatusEvent ):void
		{
			var code:String = p_e.info.code;
			trace( "onNCStatus "+code );
			if( code == "NetConnection.Connect.Success" ){
				trace("FMS Success");
				fms = true;
				
			} else if (code == "NetConnection.Connect.Fail"){
				trace("FMS FAIL!");
			}
		};
		
		private function initStratus():void{
            nc = new NetConnection( ); 
            nc.connect (stratusGo + "/" + devKey); 
			nc.maxPeerConnections = 50;
			nc.addEventListener (NetStatusEvent.NET_STATUS,stratusNCStatus);
		}
		
		private function stratusNCStatus( p_e:NetStatusEvent ):void
		{
			var code:String = p_e.info.code;
			trace( "onNCStatus "+code );
			if( code == "NetConnection.Connect.Success" ){
			
				trace("Stratus Success");
				stratus = true;
				nameSplash.niShower.text = nc.nearID;
				
			} else if (code == "NetConnection.Connect.Fail"){
				trace("FAIL!");
			} else if (code == "NetStream.Connect.Success"){
				
				
			} else if (code == "NetStream.Connect.Closed"){
				
			}
		};
		
		private function enterChat(e:MouseEvent):void{
			myName = nameSplash.nameInput.text;
			trace(myName);
			if(myName == "name"){
				nameSplash.warning.visible = true;
			} else {
				myName = nameSplash.nameInput.text;
				nameSplash.visible = false;
				startConnectionProcess();
				this.addEventListener(KeyboardEvent.KEY_DOWN, addChat);
				
			}
			
		}
		
		private function onSSData( p_o:Object ):void
		{
			trace("onSSData  ");
		};
		private function onFail( p_o:Object ):void
		{
			trace("onFail  "+p_o);
		};
		
		private function initNS():void{
			listenerStream = new NetStream(nc, NetStream.DIRECT_CONNECTIONS);
				
				var c:Object = new Object
				c.onPeerConnect = function(caller:NetStream):Boolean
				{
						createInStream(caller);
						return true;
				}
				
				listenerStream.client = c;
				
				listenerStream.publish(String("listener" + so.data.num));
				
				
			outNS = new NetStream(nc, NetStream.DIRECT_CONNECTIONS); 
			outNS.publish("stratChat" );
			var result:Responder = new Responder ( onSSData, onFail );
				nc1.call( "registerUser",result);
		}
		
		private function makeSO():void{
			so = SharedObject.getRemote( "chat", nc1.uri );
			so.addEventListener(SyncEvent.SYNC, onSOSync);
			so.connect( nc1 );
			so.client = new Object();
			incomingStreams = new Array();
			so.client.userConnected = function( p_sID )
			{
				nameArea.text = "";
				for(var na:uint = 0; na < so.data.names.length; na++){
					nameArea.text += so.data.names[na] + "\n";
					trace("What what "+ [na] + so.data.names[na]);
				}
			}
		}
		//THIS UPDATES THE MEMBER LIST ON EVERY SO UPDATE
		private function onSOSync( p_e:SyncEvent ):void
		{
			nameArea.text = "";
			for(var na:uint = 0; na < so.data.names.length; na++){
				nameArea.text += so.data.names[na] + "\n";
			}
			
			
		};
		
		private function startConnectionProcess():void{
			if(so.data.firstOne != null){
				additionalPeers();
			} else {
				firstPeer();}
			initNS();
		}
		
		private function firstPeer():void{
			so.setProperty("firstOne", true);
			so.setDirty("firstOne");
			idA = new Array();
			names = new Array();
			names.push(myName);
			so.setProperty("names", names);
			so.setDirty("names");
			idA.push(nc.nearID);
			so.setProperty("chatIDS", idA);
			so.setDirty("chatIDS");
			so.setProperty("num", 0);
			so.setDirty("num");
		}
		
		private function additionalPeers():void{
			nameArea.text = "";
				for(var na:uint = 0; na < so.data.names.length; na++){
					nameArea.text += so.data.names[na] + "\n";
				}
				
				so.data.names.push(myName);
				so.setDirty("names");
				
				//SETS UP ALL INPUTS TO PEERS THAT ARE ALREADY CONNECTED VIA SO.
				for(var sd:uint = 0; sd < so.data.chatIDS.length; sd++){
					controlNS = new NetStream(nc, so.data.chatIDS[sd]);
					controlNS.play(String("listener" + sd));
					trace(so.data.chatIDS[sd]);
					inNS = new NetStream(nc, so.data.chatIDS[sd]);
					
						var i:Object = new Object();
						i.onIm = function(chat:String):void
							{
								chatArea.text += chat + "\n";
								
							}
						inNS.client = i;
						inNS.play("stratChat");
						incomingStreams.push(inNS);
						trace(incomingStreams.length + " NUMBER OF IN STREAMS" + " " + sd);
				}
				var myNum:Number = so.data.num +1;
				so.setProperty("num", myNum);
				so.setDirty("num");
				so.data.chatIDS.push(nc.nearID);
				so.setDirty("chatIDS");
		}
		
		private function createInStream(caller:NetStream):void{
			inNS = new NetStream(nc, caller.farID);
						
			var i:Object = new Object();
			i.onIm = function(chat:String):void
			{
					chatArea.text += chat + "\n";
								
			}
			inNS.client = i;
			incomingStreams.push(inNS);
			inNS.play("stratChat");
		}
		
		private function addChat(e:KeyboardEvent):void{
			if(e.keyCode == Keyboard.ENTER){
				trace("FIRED");
				
				outNS.send("onIm", myName + ": " + chatMe.text);
				chatArea.text += myName + ": " + chatMe.text + "\n";
				chatMe.text = "";
			}
		}
		
		private function makeChat(s:String):void{
			chatArea.appendText(s + "\n");
		}
		
		private function checker(e:Event):void{
			if(stratus && fms){
				makeSO();
				nameSplash.warning.visible = false;
				trace("done");
				removeEventListener(Event.ENTER_FRAME, checker);
			}
		}
	}
}