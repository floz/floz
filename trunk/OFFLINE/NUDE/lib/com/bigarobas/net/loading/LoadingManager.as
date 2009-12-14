package com.bigarobas.net.loading {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLStream;
	import flash.system.LoaderContext;
	
	/**
	* ...
	* @author Rashid Ghassempouri
	*/
	
	public class LoadingManager extends EventDispatcher implements ILoadingObject {
		
		protected var _title:String;
		protected var _queue:Array;
		protected var _lenght:int;
		protected var _totalCount:int=0;
		protected var _loadedCount:int = 0;
		protected var _nextID:int = 0;
		protected var _autoStart:Boolean = true;
		protected var _simultaneous:Boolean = false;
		protected var _isloading:Boolean = false;
		protected var _bytes_total:uint=0;
		protected var _bytes_loaded:uint = 0;
		protected var _ratio:Number=0;
		protected var _pourcent:int = 0;	
		
		protected var _onProgress:Function;
		protected var _onComplete:Function;
		protected var _onIoErreur:Function;
		protected var _onErreur:Function;
		protected var _onSecurity:Function;
		protected var _onHttp:Function;
		
		public function LoadingManager (vTitle:String = "", vAutoStart:Boolean = true, vSimultaneous:Boolean = false) { 
			_title = vTitle;
			_autoStart = vAutoStart;
			_simultaneous = vSimultaneous;
			configureListeners(this);
						
			init();
		}
		
		public function init():void {
			_queue = [];
			_lenght = 0;
			_totalCount = 0;
			_loadedCount = 0;
			_nextID = 0;
		}
		
		public function start():ILoadingObject {
			if (_simultaneous) {
				for each (var loadingObject:ILoadingObject in _queue) {
					startNext();
				}
			} else {
				startNext();
			}
			return(this);
		}
		
		public function download(vUrl:String, vOnComplete:Function = null, vContext:LoaderContext = null ,vType:String=""):ILoadingObject {
			
			var downloader:ILoadingObject;
			
			if (vType == "") vType = LoadingObjectType.getFileExtension(vUrl);
			
			switch (LoadingObjectType.getFileType(vType)) {
				case LoadingObjectType.ASSET :
					downloader = downloadAsset(vUrl, vOnComplete, vContext);
					break;
				case LoadingObjectType.DATA :
					downloader = downloadData(vUrl, vOnComplete);
					break;
				case LoadingObjectType.UNDEFINED :
					break;
			}
			
			return (downloader);
		}
		
		public function downloadAsset(vUrl:String, vOnComplete:Function = null, vContext:LoaderContext = null):ILoadingObject {
			var d:DownloadAsset = new DownloadAsset(vUrl);
			if (vOnComplete != null) d.onComplete = vOnComplete;
			if (vContext!=null) d.context = vContext;
			d.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void { onCompleteOne(d); } );
			d.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void { onProgressOne(d); } );
			d.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void { onIOErrorOne(e);} );
			d.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, function(e:HTTPStatusEvent):void {onHttpStatusOne(e);} );
			d.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:SecurityErrorEvent):void {onSecurityErrorOne(e);} );
			return (add(d));
		}
		
		public function downloadData(vUrl:String, vOnComplete:Function = null):ILoadingObject {
			var d:DownloadData = new DownloadData(vUrl);
			if (vOnComplete != null) d.onComplete = vOnComplete;
			d.addEventListener(Event.COMPLETE, function(e:Event):void { onCompleteOne(d); } );
			d.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void { onProgressOne(d); } );
			d.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void { onIOErrorOne(e);} );
			d.addEventListener(HTTPStatusEvent.HTTP_STATUS, function(e:HTTPStatusEvent):void {onHttpStatusOne(e);} );
			d.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:SecurityErrorEvent):void {onSecurityErrorOne(e);} );
			return (add(d));
		}
		
		public function downloadUrls(vOnComplete:Function=null,...urls):ILoadingObject {
			var nurls:int = urls.length;
			var vGroup:DownloadGroup = new DownloadGroup("DownloadGroupUrls ");
			vGroup.addEventListener(Event.COMPLETE, function(e:Event):void { onCompleteOne(vGroup); } );
			if (vOnComplete != null) vGroup.onComplete = vOnComplete;
			for (var i:int = 0; i < nurls; i++) { vGroup.download(urls[i]); }
			return(add(vGroup));
		}
		
		public function addDownloadGroup(vGroup:DownloadGroup,vOnComplete:Function = null):ILoadingObject {
			vGroup.addEventListener(Event.COMPLETE, function(e:Event):void { onCompleteOne(vGroup); } );
			if (vOnComplete != null) vGroup.onComplete = vOnComplete;
			return (add(vGroup));
		}
		
		public function addDownloadData(vD:DownloadData,vOnComplete:Function = null):ILoadingObject {
			vD.addEventListener(Event.COMPLETE, function(e:Event):void { onCompleteOne(vD); } );
			if (vOnComplete != null) vD.onComplete = vOnComplete;
			return (add(vD));
		}
		
		public function addDownloadAsset(vD:DownloadAsset,vOnComplete:Function = null):ILoadingObject {
			vD.addEventListener(Event.COMPLETE, function(e:Event):void { onCompleteOne(vD); } );
			if (vOnComplete != null) vD.onComplete = vOnComplete;
			return (add(vD));
		}
			
		public function add(o:ILoadingObject):ILoadingObject {
			_queue.push(o); 
			_lenght = _queue.length;
			_totalCount ++;
			
			if (_autoStart) {
				if (_simultaneous) {
					startNext();
				} else {
					if (!_isloading) {
						startNext();
					}
				}
			}
			
			calculateProgress();
			return(o);
		}
	
		public function remove(o:ILoadingObject):void {
			_loadedCount++;
			_lenght = _queue.length;
			_isloading = false;
			if (_loadedCount == _totalCount) {
				dispatchEvent(new Event(Event.COMPLETE,true,true));
			} else {
				if (_autoStart) {
					if (!_simultaneous) {
						startNext();
					}
				}
			}
			calculateProgress();
		}
		
		private function startNext():void {
			if (_nextID < _totalCount) {
				var nextLoadingObject:ILoadingObject = _queue[_nextID] as ILoadingObject;
				_nextID++;
				_isloading = true;
				nextLoadingObject.start();
			}
		}
		
		private function calculateProgress():void {
			var bl:uint = 0;
			var bt:uint = 0;
			for each (var loadingObject:ILoadingObject in _queue) {
						bl += loadingObject.bytes_loaded;
						bt += loadingObject.bytes_total;
			}
			_bytes_loaded = bl;
			_bytes_total = bt;
			_ratio = _bytes_loaded / _bytes_total;
			_pourcent = Math.round(_ratio * 100);
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, bl, bt));
		}
		
		//###############################################################################################	
		
		private function onCompleteOne(o:ILoadingObject):void{
			remove(o);
		}
		
		private function onProgressOne(o:ILoadingObject):void{
			calculateProgress();
		}
		
		private function onSecurityErrorOne(e:SecurityErrorEvent):void {
			dispatchEvent(e);
		}
		
		private function onHttpStatusOne(e:HTTPStatusEvent):void {
			dispatchEvent(e);
		}
		
		private function onIOErrorOne(e:IOErrorEvent):void {
			dispatchEvent(e);
		}
		
		//###############################################################################################	

		public function get bytes_loaded():uint { return _bytes_loaded; }
		public function get bytes_total():uint { return _bytes_total; }
		public function get ratio():Number { return _ratio; }
		public function get pourcent():int { return _pourcent; }
		public function get lenght():int { return _lenght; }
		public function get autoStart():Boolean { return _autoStart; }
		public function set autoStart(value:Boolean):void {_autoStart = value;}
		public function get simultaneous():Boolean { return _simultaneous; }
		public function set simultaneous(value:Boolean):void {_simultaneous = value;}
		public function get isloading():Boolean { return _isloading; }
		public function get title():String { return _title; }
		public function set title(value:String):void {_title = value;}
		public function get queue():Array { return _queue; }
		
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
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);

        }
		
		//###############################################################################################	
		
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
		
		private function completeHandler(event:Event):void { 
			_onComplete(event);
		}
		
		private function progressHandler(event:ProgressEvent):void { 
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
		
		//###############################################################################################
		
		override public function toString():String {
			return ("LoadingManager  " + title +" "+_loadedCount+"/"+lenght);
		}
		
		
	
	}	
	
}