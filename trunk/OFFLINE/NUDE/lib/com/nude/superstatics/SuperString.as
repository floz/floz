/**
 | N U D E
 | The low dependent flash oriented framework
 |
 | Copyright © 2009		> MIT license 					> http://www.opensource.org/licenses/mit-license.php
 | Florian Zumbrunn		> florian.zumbrunn@gmail.com	> http://www.floz.fr
 | Arnaud Nicolas		> arno06@gmail.com				> 
 | Rashid Ghassempouri	> rashid.ghassempouri@gmail.com	> http://www.bigarobas.com
 */
  
package com.nude.superstatics {
	
	/**
	* 	Class that contains static utility methods for manipulating and working with Strings
	* 	@langversion ActionScript 3.0
	*/	
	
	public class SuperString {
		
		/* Latin Lorem Ipsum model */
		public static const LOREM_IPSUM:String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
	
		/* Latin numbers */
		public static const NUMBERS:String = "0123456789";
		
		/* Basic latin letters */
		public static const LETTERS:String = "abcdefghijklmnopqrstuvwxyz";
		
		/**
		 * Generates Lorem Ipsum lines.
		 * @param	numLine The number of lines to generate
		 * @param	linesPerParagraph The number of lines to group by linebreaker Strings
		 * @param	linebreaker The line breaker String
		 * @return  The generated Lorem Ipsum paragraph String
		 */
		
		public static function getLoremIpsum(numLine:uint = 5, linesPerParagraph:int = -1, linebreaker:String = "\r"):String {
			var s:String = "";
			while (numLine-- > 0) {
				s += LOREM_IPSUM;
				if (linesPerParagraph > 0) if (numLine % linesPerParagraph == 0) s += linebreaker; 
			}
			return(s);
		}
		
		/**
		 * Retruns the extension String of an URI.
		 * @param	uri The URI String to analyse.
		 * @return  The extension String.
		 */
		
		public static function getURIExtension(uri:String):String{
			var r:Array = uri.split(".");
			return (r[r.length - 1]);
		}	
		
		/**
		 * Generates a random hash String.
		 * @param	hashLength The hash String length.
		 * @param	dictionary Caracters to use to generate the hash string.
		 * @return  A randomly generated hash String.
		 */
		
		public static function getRandomHash(hashLength:uint = 10, dictionary:String = null):String {
			
			var hash:String = "";
			if (dictionary == null) dictionary = LETTERS + NUMBERS;
			var n:int = dictionary.length-1;
			var rand:uint;
			for (var i:int = 0; i < hashLength; i++) {
				rand = SuperMath.randuint(n);
				hash += dictionary.charAt(rand);
			}
			return (hash);
		}

		/**
		 * Checks if a String is a valid email address.
		 * @param email The String to check.
		 * @return True if the String is a valid email address, False if it is not.
		 */
		
		public static function isEmail(email:String):Boolean {
			var emailExpression:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return emailExpression.test(email);
		}
		
	}
	
}