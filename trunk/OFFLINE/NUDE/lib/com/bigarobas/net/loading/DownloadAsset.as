package com.bigarobas.net.loading {
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.errors.IllegalOperationError;
	import flash.text.TextField;
	

	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class DownloadAsset extends Loader implements ILoadingObject
	{
		protected var _title:String;
		protected var _url:String;
		protected var _context:LoaderContext=null;
		
		protected var _bytes_total:uint = 0;
		protected var _bytes_loaded:uint = 0;
		protected var _ratio:Number = 0;
		protected var _pourcent:int = 0;
		
		protected var _onProgress:Function;
		protected var _onInit:Function;
		protected var _onComplete:Function;
		protected var _onIoErreur:Function;
		protected var _onErreur:Function;
		protected var _onSecurity:Function;
		protected var _onHttp:Function;
		
		//###############################################################################################
		public function DownloadAsset(urlToLoad:String = "",onCompleteFunction:Function=null,loadercontext:LoaderContext=null) {
			configureListeners(contentLoaderInfo);
			_url = urlToLoad;
			if (onCompleteFunction!=null) onComplete = onCompleteFunction;
			if (context != null) context = loadercontext;
			
			
		}
		//###############################################################################################
		public function start():ILoadingObject {
			load(new URLRequest(url), _context);
			return(this);
		}
		//###############################################################################################
		public function getClass(className:String):Class {
        try {
            return contentLoaderInfo.applicationDomain.getDefinition(className)  as  Class;
        } catch (e:Error) {
            throw new IllegalOperationError(className + " definition not found in " + this);
        }
        return null;
    }
		//###############################################################################################
		public function get title():String { return _title; }
		public function set title(value:String):void { _title = value; }
		public function get bytes_loaded():uint { return _bytes_loaded; }
		public function get bytes_total():uint { return _bytes_total; }
		public function get ratio():Number { return _ratio; }
		public function get pourcent():int { return _pourcent; }
		public function get url():String { return _url; }
		public function set url(value:String):void { _url = value; }
		public function get context():LoaderContext { return _context; }
		public function set context(value:LoaderContext):void {_context = value; }
		//###############################################################################################
		private function configureListeners(dispatcher:IEventDispatcher):void {
			
			onProgress = onProgressDefault;
			onInit = onInitDefault;
			onComplete = onCompleteDefault;
			onErreur = onErreurDefault;
			onHttp = onHttpDefault;
			onSecurity = onSecurityDefault;
			onIOErreur = onIOErreurDefault;
					
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);

        }
		
		
		//###############################################################################################			
		private function initHandler(event:Event):void { 
			_onInit(event); 
		}
		
		private function completeHandler(event:Event):void { 
			_onComplete(event);
		}
		
		private function progressHandler(event:ProgressEvent):void { 
			_bytes_loaded = uint(event.bytesLoaded);
			_bytes_total = uint(event.bytesTotal);
			_ratio = _bytes_loaded / _bytes_total;
			_pourcent = Math.round(_ratio * 100);
			_onProgress(event);
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
		public function get onInit():Function { return _onInit; }
		public function set onInit(value:Function):void { _onInit = value; }
		private function onInitDefault (event:Event):void { }
		
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
		private function onErreurDefault (e:Error):void { }
		//###############################################################################################
	
		
	}
	
}