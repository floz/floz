package com.bigarobas.utils.deeplinking {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class SWFAddressParser {
		
		private static const separator:String = "/";
		
		public static function addressToArray(vAddress:String):Array {
			var array:Array = [];
			if (vAddress.charAt(0) == separator) {
				vAddress = vAddress.substr(1, vAddress.length);
			}
			array = vAddress.split(separator);
			if (array[array.length - 1] == "") {
				array.pop();
			}
			return (array);
		}
		public static function arrayToAddress(vArray:Array):String {
			var address:String = separator;
			for each (var vString:String in vArray) {
				address += vString + separator;
			}
			
			return(address);
		}
		
		
	}
	
}