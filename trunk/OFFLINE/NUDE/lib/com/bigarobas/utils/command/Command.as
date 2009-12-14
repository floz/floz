package com.bigarobas.utils.command {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Command {
		protected var _name:String;
		protected var _parameters:Array;
		protected var _paramLength:int = 0;
		public function Command(vName:String,vParameters:Array=null) {
			name = vName;
			parameters = vParameters;
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void {
			_name = value;
		}
		
		public function get parameters():Array { return _parameters; }
		
		public function set parameters(value:Array):void {
			_parameters = value;
			_paramLength = _parameters.length;
		}
		
		public function toString():String {
			var s:String = "[";
			s += "Object Command | name = " + _name + " | parameters =";
			for(var k:int = 0; k < _paramLength; k++) {
					s+=" ("+k.toString()+" : "+_parameters[k]+") ";
			}
			s += "]";
			return(s);

		}
		
	}
	
}