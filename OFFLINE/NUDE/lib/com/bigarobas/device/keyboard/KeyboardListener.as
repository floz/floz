package com.bigarobas.device.keyboard {
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class KeyboardListener {
		protected var _proxy:EventDispatcher;
		protected var _listeners:Array;
		protected var _defaultMask:KeyboardEventMask = new KeyboardEventMask(KeyboardEvent.KEY_DOWN);
		protected var _generated_id:uint = 0;
		protected var _active:Boolean=true;
		public function KeyboardListener(vProxy:EventDispatcher) {
			
			_proxy = vProxy;
			_generated_id = 0;
			_listeners = [];
			
			_proxy.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			_proxy.addEventListener(KeyboardEvent.KEY_UP, onKey);
	
		}
		
		private function onKey(e:KeyboardEvent):void {
			if (active) {
				for each (var listener:Object in _listeners) {
					var mask:KeyboardEventMask = listener.mask;
					var f:Function = listener.f;
					if (mask.match(e)) f(e) ;
				}
			}
		}
		
		public function addEventListener (vF:Function , vMask:KeyboardEventMask = null,vID:String=null):String {
			if (vMask == null) {
				vMask = _defaultMask;
			}
			if (vID == null) {
				vID = _generated_id.toString();
				_generated_id++;
			}
			_listeners.push( { id:vID, f:vF, mask:vMask } );
			
			return (vID);
		}
		
		public function removeEventListener(vID:String):void {
			
		}
		
		public function get active():Boolean { return _active; }
		
		public function set active(value:Boolean):void {
			_active = value;
		}
		
/**
 * How to use :
 * _keyListener.addKeyListener(handlerFunction, eventMaskingFilter{ type:KeyboardEvent.KEY_DOWN, shiftKey:true, keyCode:Keyboard.UP } );
 * [KeyboardEvent type="keyDown" bubbles=true cancelable=false eventPhase=2 charCode=0 keyCode=0 keyLocation=0 ctrlKey=false altKey=false shiftKey=false]
 * 
 */


		
	}
	
}