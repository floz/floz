/**
 | N U D E
 | The low dependent flash oriented framework
 |
 | Copyright © 2009		> MIT license 					> http://www.opensource.org/licenses/mit-license.php
 | Florian Zumbrunn		> florian.zumbrunn@gmail.com	> http://www.floz.fr
 | Arnaud Nicolas		> arno06@gmail.com				> 
 | Rashid Ghassempouri	> rashid.ghassempouri@gmail.com	> http://www.bigarobas.com
 */
 
package com.nude.ui.text {

	/**
	* 	What a Label should be ^^
	* 	@langversion ActionScript 3.0
	*/
	
	public class Label extends Text {
		public function Label(vTitle:String = null) {
			super();
			_textfield.multiline = false;
			value = vTitle;
		}
		
	}

}