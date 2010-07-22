package com.gobzlite.net.loader 
{
	import com.gobzlite.events.MassLoaderEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Mass load
	 * @author David Ronai
	 */
	public class MassLoader extends EventDispatcher
	{
		
		private var urls:Array;
		private var loader:GLoader;
		private var itemLoad:Dictionary;
		private var lastName:String;
		private var totalItem:int;
		private var loadedItem:int;
		
		/**
		 * Load mass urls and dispatch event.
		 */
		public function MassLoader() 
		{
			lastName = "";
			urls = new Array();
			loader = new GLoader();
			itemLoad = new Dictionary();
		}
		
		/**
		 * Start loading
		 */
		public function start():void
		{
			totalItem = urls.length;
			loadedItem = 0;
			load();
		}
		
		/**
		 * Add one url
		 * @param	url
		 * @param	name
		 */
		public function addUrl( url:String, name:String ):void
		{
			urls.push({ url:url, name:name});
		}
		
		/**
		 * Add url to loader list
		 * @param	urls
		 * @param	names
		 */
		public function addUrls( urls:Array, names:Array ):void
		{
			for ( var i:int = urls.length - (urls.length - names.length); i < urls.length; i++) {
				names[i] = urls[i];
			}
			
			for ( i = 0; i < urls.length; i++ ) {
				addUrl( String(urls[i]), String(names[i]) );
			}
		}
		
		/**
		 * Load next item
		 */
		private function load():void
		{
			if ( urls != null && urls.length == 0 ) 
			{
				dispatchEvent( new Event(Event.COMPLETE) );
				if( loader ){
					loader.removeEventListener(Event.COMPLETE, onComplete);
					loader.dispose();
				}
				lastName = "";
				return;
			}
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			lastName = urls[0].name;
			loader.load( urls[0].url );
			urls.shift();
		}
		
		/**
		 * On current item loaded
		 * @param	e
		 */
		private function onComplete(e:Event):void 
		{
			loadedItem ++;
			dispatchEvent(new MassLoaderEvent(MassLoaderEvent.PROGRESS, loadedItem/totalItem));
			itemLoad[lastName] = loader.getContent( false );
			load();
		}		
		
		public function getItem(name:String):*
		{
			if( itemLoad[name] != undefined )
				return itemLoad[name];
			else 
				return null;
		}
		
		public function removeItem(name:String):*
		{
			delete itemLoad[name];
		}
		
		public function dispose():void
		{
			if( loader != null ){
				loader.dispose();
				loader = null;
			}
			if ( urls )
				urls = null;
			if (itemLoad )
				itemLoad = null;
		}
		
	}	
}