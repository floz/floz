
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.BitmapData;
	import flash.net.FileFilter;
	
	public class Model 
	{
		public static var MASKS:Array = [];
		public static const IMAGE_TYPE:FileFilter = new FileFilter( "Image ( '*.jpg', '*.jpeg', '*.png' )", "*.jpg; *.jpeg; *.png" );
		
		public static const PHP_UPLOAD_FILE:String = "upload.php";
		public static const PHP_UPLOAD_DIR:String = "uploadDir";
		public static var PATH_PHP:String;
		
		public static var userPhoto:BitmapData;
		public static var maskIdx:int;
		
		public static var scale:Number;
		public static var saturationValue:Number;
		public static var rotation:Number;
		public static var mirrorRatio:int;
		
		public static var enable:Boolean;
		public static var initialized:Boolean;
		
		public static var PATH_MASKS:String;
		
	}
	
}