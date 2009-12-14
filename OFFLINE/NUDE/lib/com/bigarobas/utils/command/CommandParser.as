package com.bigarobas.utils.command {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class CommandParser {
		protected var _command_breaker:String = ";";
		protected var _parameter_breaker:String = ",";
		public function CommandParser(vCom:String=";",vPar:String=",") {
			_command_breaker = vCom;
			_parameter_breaker = vPar;
		}
		
		public function parse(vS:String):Array {
			var commands:Array = [];
			commands = getCommands(vS);
			return (commands);
		}
		
		public function getCommands(vS:String):Array{
				var aCom:Array = vS.split(_command_breaker);
				var nCom:int = aCom.length-1;
				var commands:Array = [];
				for (var i:int = 0; i < nCom; i++) {
					commands.push(getCommand(aCom[i]));
				}
				return(commands);
		}
		public function getCommand(vS:String):Command {
				var command_definition:Array = vS.split(",");
				var name:String = command_definition.shift();
				var params:Array = command_definition;
				new Command(name, params);
				return (new Command(name, params));
		}
		
		
		/*
		public function parse(vS:String):Vector.<Command> {
			var commands:Vector.<Command> = new Vector.<Command>();
			commands = getCommands(vS);
			return (commands);
		}
		
		public function getCommands(vS:String):Vector.<Command> {
				var aCom:Array = vS.split(_command_breaker);
				var nCom:int = aCom.length-1;
				var commands:Vector.<Command> = new Vector.<Command>();
				for (var i:int = 0; i < nCom; i++) {
					commands.push(getCommand(aCom[i]));
				}
				return(commands);
		}
		public function getCommand(vS:String):Command {
				var command_definition:Array = vS.split(",");
				var name:String = command_definition.shift();
				var params:Array = command_definition;
				new Command(name, params);
				return (new Command(name, params));
		}
		*/
		
		public function get command_breaker():String { return _command_breaker; }
		
		public function set command_breaker(value:String):void {
			_command_breaker = value;
		}
		
		public function get parameter_breaker():String { return _parameter_breaker; }
		
		public function set parameter_breaker(value:String):void {
			_parameter_breaker = value;
		}
	}
	
}