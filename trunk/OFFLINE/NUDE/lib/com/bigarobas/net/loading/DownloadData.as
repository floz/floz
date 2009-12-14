package com.bigarobas.net.loading {

	import com.bigarobas.templates.Main;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	/**
	* ...
	* @author Rashid GHASSEMPOURI
	*/
	public class DownloadData extends URLLoader implements ILoadingObject
	{
		protected var _title:String;
		protected var _url:String;
		
		protected var _bytes_total:uint=0;
		protected var _bytes_loaded:uint = 0;
		protected var _ratio:Number=0;
		protected var _pourcent:int=0;
		
		protected var _onIoErreur:Function;
		protected var _onErreur:Function;
		protected var _onProgress:Function;
		protected var _onComplete:Function;
		protected var _onSecurity:Function;
		protected var _onHttp:Function;
		
		
		//###############################################################################################
		public function DownloadData(urlToLoad:String = "", onCompleteFunction:Function = null) {
			configureListeners(this);
			_url = urlToLoad;
			if (onCompleteFunction != null) onComplete = onCompleteFunction;	
		}
		
		//###############################################################################################
		public function start():ILoadingObject {
			try {
                load(new URLRequest(_url));
            } catch (error:Error) {
                errorHandler(error);
            }	
			return (this);
		}
		
		public function getXML():XML {
			try {
               return(new XML(data));
            } catch (error:Error) {
                errorHandler(error);
            }		
			return null;
		}
		
		public function getCSS():StyleSheet {
			try {
				var ss:StyleSheet = new StyleSheet();
				ss.parseCSS(data);
               return(ss);
            } catch (error:Error) {
                errorHandler(error);
            }		
			return null;
		}
		
		//###############################################################################################
		public function get title():String { return _title; }
		public function set title(value:String):void { _title = value; }
		public function get url():String { return _url; }
		public function set url(value:String):void { _url = value; }
		public function get bytes_loaded():uint { return _bytes_loaded; }
		public function get bytes_total():uint { return _bytes_total; }
		public function get ratio():Number { return _ratio; }
		public function get pourcent():int { return _pourcent; }		
		//###############################################################################################
		private function configureListeners(dispatcher:IEventDispatcher):void {
			
			onProgress = onProgressDefault;
			onComplete = onCompleteDefault;
			onErreur = onErreurDefault;
			onHttp = onHttpDefault;
			onSecurity = onSecurityDefault;
			onIOErreur = onIOErreurDefault;
					
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			

        }
		
		//###############################################################################################
		
		private function progressHandler(event:ProgressEvent):void { 
			_bytes_loaded = uint(event.bytesLoaded);
			_bytes_total = uint(event.bytesTotal);
			_ratio = _bytes_loaded / _bytes_total;
			_pourcent = Math.round(_ratio * 100);
			_onProgress(event);
		}

		private function completeHandler(event:Event):void {
			_onComplete(event); 
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			_onIoErreur(event);
		}

        private function httpStatusHandler(event:HTTPStatusEvent):void { 
			_onHttp(event);
		}
		
        private function securityErrorHandler(event:SecurityErrorEvent):void {
			_onSecurity(event);
		}
		
        private function errorHandler(error:Error):void {
			_onErreur(error);
		}

		//------------------------------------------------------------------------------------------------
		
        public function get onComplete():Function { return _onComplete; }
		public function set onComplete(value:Function):void { _onComplete = value; }
		private function onCompleteDefault (event:Event):void { }
		
		public function get onProgress():Function { return _onProgress;}
		public function set onProgress(value:Function):void { _onProgress = value; }
		private function onProgressDefault (event:ProgressEvent):void { }
		
		public function get onIOErreur():Function { return _onIoErreur; }
		public function set onIOErreur(value:Function):void { _onIoErreur = value; }
		private function onIOErreurDefault (event:IOErrorEvent):void { }
		
		public function get onHttp():Function { return _onHttp; }
		public function set onHttp(value:Function):void { _onHttp = value; }
		private function onHttpDefault (event:HTTPStatusEvent):void { }
		
		public function get onSecurity():Function { return _onSecurity; }
		public function set onSecurity(value:Function):void { _onSecurity = value; }
		private function onSecurityDefault (event:SecurityErrorEvent):void { }
		
		public function get onErreur():Function { return _onErreur; }
		public function set onErreur(value:Function):void { _onErreur = value; }
		private function onErreurDefault (event:Error):void { }
		
		//###############################################################################################
		
	}
}