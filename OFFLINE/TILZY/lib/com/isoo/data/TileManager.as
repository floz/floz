package com.isoo.data 
{
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author David Ronai
	 */
	public class TileManager
	{
		private static const images:Dictionary = new Dictionary(); 
		
		public static function getImage(key:int):BitmapData {
			return images[key];
		}
		
		public static function removeImage(key:int):void {
			delete images[key];
		}
		
		public static function addImage(key:int, bitmapData:BitmapData):void {
			images[key] = bitmapData;
		}
		
	}

}