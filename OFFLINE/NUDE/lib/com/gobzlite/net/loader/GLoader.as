package com.gobzlite.net.loader 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	/**
	 * Simple loader
	 * 
	 * @author DavidRonai
	 */
	public class GLoader extends EventDispatcher
	{
		
		private var _loader:Loader;
		private var _itemLoaded:DisplayObject;
		
		/**
		 * Simple Loader
		 * @param url URL to load or null to load after
		 */
		public function GLoader( url:String="" ) 
		{
			if ( url != "" )
				load( url );
		}
		
		/**
		 * Load file 
		 * @param	url File url
		 */
		public function load( url:String ):void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.load( new URLRequest( url ) );
		}
		private function onComplete( e:Event ):void 
		{
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			_itemLoaded = _loader.content;
			dispatchEvent( new Event(Event.COMPLETE) );
			disposeLoader();
		}
		
		/**
		 * Return content loaded
		 * @param	dispose dispose loader
		 * @return content loaded
		 */
		public function getContent( dispose:Boolean=true ):DisplayObject
		{
			var tmp:DisplayObject = _itemLoaded;
			if ( dispose )
				this.dispose();
			return tmp;		
		}
		
		/**
		 * Clean memory
		 */
		public function dispose():void
		{
			 disposeLoader();
			_itemLoaded = null;
		}
		
		/**
		 * Remove loader
		 */
		private function disposeLoader():void
		{
			/*
			if ( _loader ) {
				try	{ _loader.close(); }
				catch ( e:Error ) { }
				_loader.unload();
				_loader = null;
			}
			*/
		}
	}
	
}