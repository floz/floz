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
	* 	Class that contains static utility methods for Mathematic operations
	* 	@langversion ActionScript 3.0
	*/	
	
	public class SuperMath {
		
		/**
		 * Return a random positive or negative Number between -n and n.
		 * @param	n The random boundary.
		 * @return  A random Number between -n and n.
		 */
		
		public static function rand(n:Number):Number {
			return ((Math.random() * 2 - 1) * n);
		}
		
		/**
		 * Return a random positive Number between 0 and n.
		 * @param	n The random boundary.
		 * @return  A random positive Number between 0 and n.
		 */
		
		public static function randabs(n:Number):Number {
			return (Math.random()*n);
		}
		
		/**
		 * Return a random positive or negative int between -n and n.
		 * @param	n The random boundary.
		 * @return  A random positive or negative int between -n and n.
		 */
		
		public static function randint(n:Number):int {
			return (Math.round(rand(n)));
		}
		
		/**
		 * Return a random positive int between 0 and n.
		 * @param	n The random boundary.
		 * @return  A random positive int between 0 and n.
		 */
		
		public static function randuint(n:Number):uint {
			return (Math.round(randabs(n)));
		}
	}
	
}