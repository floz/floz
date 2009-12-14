package com.bigarobas.superstatics {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class SuperString {
		
		protected static const LOREM_IPSUM:String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
		protected static const NUMBERS:String = "0123456789";
		protected static const LETTERS:String = "abcdefghijklmnopqrstuvwxyz";
		
		public static function isEmail(email:String):Boolean {
			var emailExpression:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return emailExpression.test(email);
		}
		
		public static function getLoremIpsum(n:int = 10, pl:int = 5, ps:String = "\r"):String {
			var i:int = 0;
			var s:String;
			while (i < n) {
				s += LOREM_IPSUM;
				if (i % pl == 0) s += ps;
				i++;
			}
			return(s);
		}
		
		public static function getFileExtension(vFileName:String):String{
			var r:Array = vFileName.split(".");
			return (r[r.length - 1]);
		}
		
		
		public static function getRandomHash(vN:uint = 10):String {
			var hash:String = "";
			var nl:int = LETTERS.length;
			var rand:uint;
			for (var i:int = 0; i < vN; i++) {
				rand = SuperMath.randuint(nl - 1);
				hash += LETTERS.charAt(rand);
			}
			return (hash);
		}
		
		
		
	}
	
}