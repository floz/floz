package com.gobzlite.display 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	/**
	 * Load and manage CSS
	 * @author DavidRonai
	 */
	public class CSS extends EventDispatcher
	{
		static private var _style:StyleSheet = new StyleSheet();
		static private var _callback:Function;
		
		public function CSS() 
		{
			throw new Error("You can't create an instance of CSS");
		}
		
		/**
		 * Load style CSS
		 * 
		 * @param	url url where is css file
		 * @param	callback Callback function call when css is loaded else CSS dispatch an event
		 */
		public static function load( url:String, callback:Function = null ):void
		{
			_callback = callback;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load( new URLRequest( url ) );
		}
		
		static private function onLoadComplete(e:Event):void 
		{
			var loader:URLLoader = (e.target as URLLoader);
			loader.removeEventListener(Event.COMPLETE, onLoadComplete);
			
			style.parseCSS( loader.data );
			
			if( _callback != null )
				_callback();			
		}
		
		/**
		 * Return CSS style
		 */
		static public function get style():StyleSheet { return _style; }
		
	}
	
}