package com.bigarobas.events {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class FullEvent {
		protected var _type:String;
		protected var _target:FullEventDispatcher;
		protected var _currentTarget:FullEventDispatcher;
		public function FullEvent(vType:String) {
			_type = vType;
		}
		
		public function get type():String { return _type; }

		public function get target():FullEventDispatcher { return _target; }
		
		public function set target(value:FullEventDispatcher):void {
			_target = value;
		}
		
		public function get currentTarget():FullEventDispatcher { return _currentTarget; }
		
		public function set currentTarget(value:FullEventDispatcher):void {
			_currentTarget = value;
		}
		
	}
	
}