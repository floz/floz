package com.gobzlite.net 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	
	/**
	 * Get yahoo weather 
	 * @author DavidRonai
	 */
	public class YahooWeather extends EventDispatcher
	{
		
		public static const PARIS_CODE:String = 615702;
		public static const URL_YAHOO_WEATHER:String = "http://weather.yahooapis.com/forecastrss";
		
		public static const CELSUS:int = 	0x000001;
		public static const FARENHEIT:int = 0x000002;
		
		private var _max:int;
		private var _min:int;
		private var _condition:String;
		
		private var _callback:Function;
		
		private var loader:URLLoader;
		
		/**
		 * 
		 */
		public function YahooWeather() 
		{
			throw new Error("You can't create an instance of YahooWeather");
		}
		
		/**
		 * Load information from Yahoo Weather
		 * 
		 * @param	zipCode please check your code on yahoo
		 * @param	type select celsus or farenheit, celsus by default
		 */
		static public function load(zipCode, type:int = YahooWeather.CELSUS, callback:Function=null):void
		{
			_callback = callback;
			
			// suffix argument : celsus or farenheit
			var suffix:String;
			if (type == YahooWeather.FARENHEIT)
				suffix = "&u=f";
			else 
				suffix = "&u=c";
			
			//create url
			var url:String = URL_YAHOO_WEATHER + "?w=" + zipCode+suffix;
			
			//load url
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load( new URLRequest(url) );
		}
		
		static private function onComplete(e:Event):void 
		{
			var yWeather:Namespace = xml.namespace("yweather");
			
			_min = xml.channel.item.yWeather::forecast.@low[0];
			_max = xml.channel.item.yWeather::forecast.@high[0];
			_condition = xml.channel.item.yWeather::forecast.@text[0];
			
			if ( _callback != null )
				_callback();
			else
				dispatchEvent(new Event(Event.COMPLETE) );
		}
		
		public function get max():int { return _max; }
		
		public function get min():int { return _min; }
		
		public function get condition():String { return _condition; }
		
	}
	
}