package com.bigarobas.superstatics {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class SuperMath {
		
		public static function rand(n:Number):Number {
			return ((Math.random() * 2 - 1) * n);
		}
		
		public static function randabs(n:Number):Number {
			return (Math.abs(rand(n)));
		}
		
		public static function randint(n:int):int {
			return (Math.round((Math.random() * 2 - 1) * n));
		}
		
		public static function randuint(n:int):uint {
			return (Math.abs(randint(n)));
		}
	}
	
}