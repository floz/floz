package com.bigarobas.superstatics {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class SuperDate {

		public static function ymd():int {
			return (int(ymdString()));
		}
		public static function ymdString():String {
			var date:Date = new Date();
			return (dateToYMD(date));
		}
		
		public static function ymdToFormat(ymd_date:String, sep:String = ""):String {
			
			var year:String = ymd_date.slice(0, 4);
			var month:String = ymd_date.slice(4, 6);
			var day:String = ymd_date.slice(6, 8);
			return (day + sep + month + sep + year);
		}
		
		public static function dateToYMD(d:Date):String{
			
			var day:int=d.getDate();
			var month:int =d.getMonth() + 1;
			var year:int =d.getFullYear();
			var result:String="";
			result += year.toString();
			if (month < 10) {
				result += "0" + month.toString();
			}else {
				result += month.toString();
			}
			if (day < 10) {
				result += "0" + day.toString();
			}else {
				result += day.toString();
			}
			return (result);
		}
	}
	
}