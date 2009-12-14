package com.bigarobas.utils.command {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Shell {
		protected var _parser:CommandParser;
		protected var _dictionary:CommandDictionary;
		public function Shell(vDico:CommandDictionary=null) {
			if (vDico == null) {
				vDico = new CommandDictionary();
			}
			
			dictionary = vDico;
			_parser = new CommandParser();
			
		}
		
		public function execute(vS:String):void {
			if (vS.charAt(vS.length - 1) != _parser.command_breaker) vS += _parser.command_breaker;
			var commands:Array = _parser.parse(vS);
			for each(var command:Command in commands) {
				executeCommand(command);
			}	
		}
		
		/*
		public function execute(vS:String):void {
			if (vS.charAt(vS.length - 1) != _parser.command_breaker) vS += _parser.command_breaker;
			var commands:Vector.<Command> = _parser.parse(vS);
			for each(var command:Command in commands) {
				executeCommand(command);
			}	
		}
		*/
		public function executeCommand(vC:Command):void {
			if (_dictionary.has(vC.name)) _dictionary.getCommand(vC.name).f(vC.parameters);
		}
		
		public function get dictionary():CommandDictionary { return _dictionary; }
		
		public function set dictionary(value:CommandDictionary):void {
			_dictionary = value;
		}
		
		public function get parser():CommandParser { return _parser; }
		
		public function set parser(value:CommandParser):void {
			_parser = value;
		}
		
	}
	
}