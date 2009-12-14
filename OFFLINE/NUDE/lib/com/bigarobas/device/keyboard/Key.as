package com.bigarobas.device.keyboard {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Key {
		
		protected var _char:String;
		protected var _keyCode:int;
		protected var _charCode:int;
		
		public function Key(vChar:String="",vKeyCode:int=-1,vCharCode:int=-1) {
			_keyCode = vKeyCode;
			_charCode = vCharCode;
			_char = vChar;
		}
		
		public function get char():String { return _char; }
		
		public function set char(value:String):void {
			_char = value;
		}
		
		public function get keyCode():int { return _keyCode; }
		
		public function set keyCode(value:int):void {
			_keyCode = value;
		}
		
		public function get charCode():int { return _charCode; }
		
		public function set charCode(value:int):void {
			_charCode = value;
		}
		
	}
	
}