package com.bigarobas.utils.command {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class CommandDefinition {
		protected var _name:String;
		protected var _f:Function;
		protected var _description:String;
		public function CommandDefinition(vName:String, vF:Function,vDesc:String="") {
			_name = vName;
			_f = vF;
			_description = vDesc;
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void {
			_name = value;
		}
		
		public function get f():Function { return _f; }
		
		public function set f(value:Function):void {
			_f = value;
		}
		
		public function get description():String { return _description; }
		
		public function set description(value:String):void {
			_description = value;
		}
		
	}
	
}