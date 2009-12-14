package com.bigarobas.utils.command {
	
	import com.bigarobas.templates.Main;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class CommandDictionary {
		private var _commands:Array;
		private var _commandsPush:Array;
		public function CommandDictionary() {
			_commands = [];
			_commandsPush = [];
			initDefaultCommands();
		}
		
		public function add(vCD:CommandDefinition):void {
			_commands[vCD.name] = vCD;
			_commandsPush.push(vCD);
		}
		
		
		public function remove(vName:String):void {
			if (has(vName)) {
				var cd:CommandDefinition = _commands[vName];
				_commandsPush.splice(_commandsPush.indexOf(cd), 1);
				_commands[vName] = null;
			}
		}
		
		public function has(vName:String):Boolean {
			return (_commands[vName] is CommandDefinition);
		}
		
		public function getCommand(vName:String):CommandDefinition {
			return (_commands[vName]);
		}
		
		public function guess(vS:String):Array {
			var vSL:int = vS.length;
			//var cmd:CommandDefinition;
			var cmds:Array = _commandsPush.filter(
				function(element:*, index:int, arr:Array):Boolean {
					var c:CommandDefinition = element as CommandDefinition;
					return (c.name.slice(0, vSL) == vS);
				}
			);
			//if (cmds.length == 1) cmd = cmds[0];
			//else cmd = null;
			return (cmds);
        }

		//#################################################
		private function initDefaultCommands():void{
			add(
				new CommandDefinition(
					"test" ,
					function (vParams:Array):void { trace (vParams); } ,
					"test function"
				)
			);
			
			
		}
		
		public function get commands():Array { return _commands; }
		
		
	}
	
}