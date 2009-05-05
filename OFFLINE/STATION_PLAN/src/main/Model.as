
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.BitmapData;
	
	public class Model 
	{
		
		public static var datas:Array = [];
		public static var colors:Array = [ 0x00ff00, 0xfff000, 0x0000ff, 0xff0000, 0xff00ff, 0x00ffff ];
		
		public static var delay:Number;
		public static var logourl:String;
		
		public static var currentItem:Object;
		public static var currentPuce:Puce;
		public static var currentListIndex:int;
		
		public static var mainTooltipVisible:Boolean;
		
		public static var map:BitmapData;
		public static var logo:BitmapData;
		
		public static var path_photos:String;
	}
	
}