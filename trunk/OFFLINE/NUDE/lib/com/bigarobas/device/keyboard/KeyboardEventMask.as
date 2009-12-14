package com.bigarobas.device.keyboard {
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class KeyboardEventMask{
		
		protected var _type:String;
		protected var _typeSet:Boolean = false;
		protected var _charCode:uint;
		protected var _charCodeSet:Boolean = false;
		protected var _keyCode:uint;
		protected var _keyCodeSet:Boolean = false;
		protected var _ctrlKey:Boolean;
		protected var _ctrlKeySet:Boolean = false;
		protected var _shiftKey:Boolean;
		protected var _shiftKeySet:Boolean = false;
		protected var _altKey:Boolean;
		protected var _altKeySet:Boolean = false;
		protected var _keyLocation:uint;
		protected var _keyLocationSet:Boolean = false;
		
		public function KeyboardEventMask (
			vType:String = null,
			vCharCode:int = -1,
			vKeyCode:int = -1,
			vShiftKey:int = -1,
			vCtrlKey:int = -1,
			vAltKey:int = -1,
			vKeyLocation:int = -1
		) 
		{ 
			
			if (vType != null) type = vType;
			if (vCharCode != -1) charCode = uint(vCharCode);
			if (vKeyCode != -1) keyCode = uint(vKeyCode);
			if (vCtrlKey != -1) ctrlKey = Boolean(vCtrlKey);
			if (vShiftKey != -1) shiftKey = Boolean(vShiftKey);
			if (vAltKey != -1) altKey = Boolean(vAltKey);	
			if (vKeyLocation != -1) keyLocation = uint(vKeyLocation);
			
		}
		
		public function match(e:KeyboardEvent):Boolean {
			
				var match:Boolean = true;
				
				if (_typeSet) if (e.type != type) match = false;
				if (_charCodeSet) if (e.charCode != charCode) match = false;
				if (_keyCodeSet) if (e.keyCode != keyCode) match = false;
				if (_ctrlKeySet) if (e.ctrlKey != ctrlKey) match = false;
				if (_shiftKeySet) if (e.shiftKey != shiftKey) match = false;
				if (_altKeySet) if (e.altKey != altKey) match = false;
				if (_keyLocationSet) if (e.keyLocation != keyLocation) match = false;
				
				return (match);
				
		}	
		
		public function get type():String { return _type; }
		
		public function set type(value:String):void {
			_type = value;
			_typeSet = true;
		}
		
		public function get charCode():uint { return _charCode; }
		
		public function set charCode(value:uint):void {
			_charCode = value;
			_charCodeSet = true;
		}
		
		public function get keyCode():uint { return _keyCode; }
		
		public function set keyCode(value:uint):void {
			_keyCode = value;
			_keyCodeSet = true;
		}
		
		public function get ctrlKey():Boolean { return _ctrlKey; }
		
		public function set ctrlKey(value:Boolean):void {
			_ctrlKey = value;
			_ctrlKeySet = true;
		}
		
		public function get shiftKey():Boolean { return _shiftKey; }
		
		public function set shiftKey(value:Boolean):void {
			_shiftKey = value;
			_shiftKeySet = true;
		}
		
		public function get altKey():Boolean { return _altKey; }
		
		public function set altKey(value:Boolean):void {
			_altKey = value;
			_altKeySet = true;
		}
		
		public function get keyLocation():uint { return _keyLocation; }
		
		public function set keyLocation(value:uint):void {
			_keyLocation = value;
			_keyLocationSet = true;
		}
		
	}
}	
