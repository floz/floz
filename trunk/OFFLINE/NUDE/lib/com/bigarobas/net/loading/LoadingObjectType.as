package com.bigarobas.net.loading {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class LoadingObjectType {
		
		public static const ASSET:String = "asset";
		public static const DATA:String = "data";
		public static const UNDEFINED:String = "undefined";
		
		public static const ASSETS:Array =  ["swf", "jpg", "jpeg", "bmp", "png"];
		public static const DATAS:Array = ["xml", "txt", "css", "rss"];
		
		public static function getFileType(vFileName:String = ""):String {
			var type:String = UNDEFINED;
			switch (true) {
				case (isAsset(vFileName)):
					type = ASSET;
					break;
				case (isData(vFileName)):
					type = DATA;
					break;
			}
			return (type);
		}
		
		public static function getFileExtension(vFileName:String):String{
			var r:Array = vFileName.split(".");
			return (r[r.length - 1]);
		}
		
		public static function isAsset(vFileExtension:String):Boolean {
			return ((ASSETS.indexOf(vFileExtension) != -1) ? true : false) ;
		}
		
		public static function isData(vFileExtension:String):Boolean {
			return ((DATAS.indexOf(vFileExtension) != -1) ? true : false) ;
		}
		
	}
	
}