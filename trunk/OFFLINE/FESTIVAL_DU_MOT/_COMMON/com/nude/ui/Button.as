/**
 | N U D E
 | The low dependent flash oriented framework
 |
 | Copyright © 2009		> MIT license 					> http://www.opensource.org/licenses/mit-license.php
 | Florian Zumbrunn		> florian.zumbrunn@gmail.com	> http://www.floz.fr
 | Arnaud Nicolas		> arno06@gmail.com				> 
 | Rashid Ghassempouri	> rashid.ghassempouri@gmail.com	> http://www.bigarobas.com
 */
 
package com.nude.ui {

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	* 	What a Button should be ^^
	* 	@langversion ActionScript 3.0
	*/
	
	public class Button extends Component {
		
		protected var _onClick:Function;
		protected var _onOver:Function;
		protected var _onOut:Function;
		
		public function Button(d:DisplayObject, fclick:Function = DEFAULT_CALLBACK, fover:Function = DEFAULT_CALLBACK, fout:Function = DEFAULT_CALLBACK) {
			buttonMode = true;
			addChild(d);
			_onClick = fclick;
			_onOut = fout;
			_onOver = fover;
			addEventListener(MouseEvent.CLICK, onMouseClick);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		private function onRollOut(e:MouseEvent):void {
			_onOut();
		}
		
		private function onRollOver(e:MouseEvent):void {
			_onOver();
		}
		
		protected function onMouseClick(e:MouseEvent):void {
			_onClick();
		}
		
		public function get onClick():Function { return _onClick; }
		
		public function set onClick(value:Function):void {
			_onClick = value;
		}
		
		public function get onOver():Function { return _onOver; }
		
		public function set onOver(value:Function):void {
			_onOver = value;
		}
		
		public function get onOut():Function { return _onOut; }
		
		public function set onOut(value:Function):void {
			_onOut = value;
		}
		
	}

}