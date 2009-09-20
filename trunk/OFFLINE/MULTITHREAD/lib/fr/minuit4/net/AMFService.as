package fr.minuit4.net 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	public class AMFService extends EventDispatcher
	{
		private var _connexion:NetConnection;
		
		public function AMFService(pServer:String) 
		{
			_connexion = new NetConnection();
			_connexion.addEventListener(NetStatusEvent.NET_STATUS, onStatus);
			_connexion.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_connexion.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			_connexion.connect(pServer);
		}
		
		public function call(pCommand:String, pParams:Object = null, pSuccess:Function = null, pFail:Function = null):void
		{
			var r:Responder = new Responder((pSuccess is Function)?pSuccess:onSuccess, (pFail is Function)?pFail:onFail);
			_connexion.call(pCommand, r, pParams);
		}		
		
		private function onAsyncError(e:AsyncErrorEvent):void 
		{
			dispatchEvent(e);
			trace("onAsyncError : "+ e);
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
			trace("onError : "+ e);
		}
		
		private function onStatus(e:NetStatusEvent):void 
		{
			dispatchEvent(e);
			trace("onStratusError : "+ e);
		}
		
		private function onFail(pFail:* = null):void
		{
			trace("Epic Fail : " + pFail);
		}
		
		private function onSuccess(pRetour:* = null):void
		{
			trace("Success : " + pRetour);
		}	
	}
	
}