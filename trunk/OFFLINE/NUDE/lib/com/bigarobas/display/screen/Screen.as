package com.bigarobas.display.screen {
	import com.bigarobas.display.layer.Layer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Screen extends Layer {
		
		public static var SCREENSHOT_RENDERED:String = "screenshots_rendered";
		
		public function Screen() {
		}
		
		public function getScreenShot():Bitmap {
			var sdata:BitmapData = new BitmapData(width, height);
			sdata.draw(this);
			dispatchEvent(new Event(SCREENSHOT_RENDERED));
			return (new Bitmap(sdata));

		}
		
	}
	
}