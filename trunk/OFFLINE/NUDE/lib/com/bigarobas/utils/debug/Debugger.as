package com.bigarobas.utils.debug {
	import com.bigarobas.device.keyboard.KeyboardEventMask;
	import com.bigarobas.device.keyboard.KeyboardListener;
	import com.bigarobas.display.layout.Layout;
	import com.bigarobas.display.layout.LayoutMode;
	import com.bigarobas.utils.command.CommandDefinition;
	import com.bigarobas.utils.command.Shell;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Debugger extends Layout {
		protected var _stage:Stage;
		protected var _debugTxt:TextField;
		protected var _inputTxt:TextField;
		protected var _infosTxt:TextField;
		protected var _shell:Shell;
		protected var _keyboardListener:KeyboardListener;
		
		protected var _message:String = "";
		protected var _g:Graphics;
		protected var _bgColor:uint = 0x000000;
		protected var _flashTraceMode:Boolean = true;
		protected var _memorySecurity:Boolean = true;
		protected var _memorySecurityMaxLines:int = 100;
		protected var _appendable:Boolean = true;
		protected var _memorySecurityAutoClear:Boolean = false;
		
		protected var _txtColor:uint = 0x00CC00;
		protected var _txtColorPRINT:String = "00CC00";
		protected var _txtColorWARNING:String = "FFCC00";
		protected var _txtColorFATAL:String = "FF0000";
		protected var _txtColorERROR:String = "FF6600";
		
		protected var _tf:TextFormat;
		
		protected var _breaklineString:String = "\r";
		protected var _paramBreakerString:String = " | ";
		protected var _lineString:String = "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾";
		protected var _debugMode:Boolean = false;
		
		protected var _header:Layout;
		protected var _monitor:HiResStats;
		
		
		
		public function Debugger(vStage:Stage, vShell:Shell = null) {
			
			_stage = vStage;
			_g = _bg.graphics;
			
			if (vShell == null) vShell = new Shell(); 	
			shell = vShell;
			
			keyboardListener = new KeyboardListener(_stage);
			
			_monitor = new HiResStats();
			
			_tf = new TextFormat("_sans", 10, _txtColor);	
			
			_inputTxt = new TextField();
			_inputTxt.type = TextFieldType.INPUT;
			_inputTxt.multiline = false;
			_inputTxt.height = 20;
			_inputTxt.defaultTextFormat = _tf;
			_inputTxt.border = true;
			_inputTxt.borderColor = _txtColor;
			_inputTxt.text = "";
			
			_debugTxt = new TextField();
			_debugTxt.multiline = true;
			//_debugTxt.autoSize = TextFieldAutoSize.LEFT;
			_debugTxt.defaultTextFormat = _tf;
			_debugTxt.wordWrap = true;
			_debugTxt.border = true;
			_debugTxt.borderColor = _txtColor;
			
			layoutOptions.mode = LayoutMode.VERTICAL;
			layoutOptions.spacing = 5;
			padding = 5;
			
			_header = new Layout();
			_header.layoutOptions.mode = LayoutMode.HORIZONTAL;
			_header.layoutOptions.spacing = 5;
			
			_header.addChild(_monitor);
			_header.addChild(_inputTxt);
			
			addChild(_header);
			addChild(_debugTxt);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			clear();
		}
		
		private function onRemoveFromStage(e:Event):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onShellKeyDown);
			
		}
		
		protected function draw():void {
			
			_g.clear();
			_g.beginFill(_bgColor, 0.9);
			_g.drawRect(0, 0, _stage.stageWidth, _stage.stageHeight);
			_g.endFill();
			
			_inputTxt.width = _stage.stageWidth - _paddingLeft - _paddingRight - 75;
			_inputTxt.height = 100;
			
			_debugTxt.width = _stage.stageWidth - _paddingLeft - _paddingRight;
			_debugTxt.height = _stage.stageHeight - _paddingTop - _paddingBottom - layoutOptions.spacings[0] - 100;
			_debugTxt.htmlText = _message;
			
			
		}
		
		
		public function redraw():void {
			draw();
		}
		
		public function switchDisplay():void {
			debugMode = !debugMode;
		}
		public function show():void {
			debugMode = true;
		}
		
		public function hide():void {
			debugMode = false;
		}
		
		protected function onAddedToStage(e:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onShellKeyDown);
			redraw();
			_header.rearrange();
			rearrange();
		}
		
		private function onShellKeyDown(e:KeyboardEvent):void {
			
			if (e.keyCode == Keyboard.ENTER) {
				_shell.execute(_inputTxt.text);
			}
		}
		
		public  function printTitle(o:*):void {
			print (o);
			print (_lineString);
		}
		
		public function print(...args):void {			
			for each (var o:* in args) {
				printMessage(o, _txtColorPRINT);
			}
			appendMessage(_breaklineString);
		}
		
		public function fatal(...args):void {			
			for each (var o:* in args) {
				printMessage(o, _txtColorFATAL);
			}
			appendMessage(_breaklineString);
		}
		
		public function error(...args):void {			
			for each (var o:* in args) {
				printMessage(o, _txtColorERROR);
			}
			appendMessage(_breaklineString);
		}
		
		public function warn(...args):void {
			for each (var o:* in args) {
				printMessage(o, _txtColorWARNING);
			}
			appendMessage(_breaklineString);
		}
		
		private function printMessage(vMessage:*, vColor:String = "00CC00"):void {
			appendMessage("<font color=\"#" +	vColor + "\">");
			var s:String = vMessage.toString();
			appendMessage(_paramBreakerString + s.toString());
			appendMessage("</font>");
			if (_flashTraceMode) trace(s);
		}
		
		public  function clear():void {
			_message = "";
			redraw();
			printTitle("Debugger");
		}
		
		private function appendMessage(o:*):void {
			var s:String = "";
			if (_memorySecurity) {
				if (_debugTxt.numLines > _memorySecurityMaxLines) {
					if (_appendable) {
						_message += _breaklineString + "DEBUGGER MEMORY LIMIT : CLEAR !";
						if (_memorySecurityAutoClear) {
							clear();
							print ("DEBUGGER MEMORY LIMIT : AUTO CLEARED !");
						}
						redraw();
					}
					_appendable = false;
					
				} else {
					_appendable = true;
				}
			}
			
			if (_appendable) {
				s = o.toString();
				_message += s;
				redraw();
			}
		}
		
		public function get flashTraceMode():Boolean { return _flashTraceMode; }
		
		public function set flashTraceMode(value:Boolean):void {
			_flashTraceMode = value;
		}
		
		public function get debugMode():Boolean { return _debugMode; }
		
		public function set debugMode(value:Boolean):void {
			_debugMode = value;
			if (_debugMode) _stage.addChild(this);
			else if (parent) parent.removeChild(this);
		}
		
		public function get shell():Shell { return _shell; }
		
		public function set shell(value:Shell):void {
			_shell = value;
			setupSell(_shell);
		}
		
		public function get keyboardListener():KeyboardListener { return _keyboardListener; }
		
		public function set keyboardListener(value:KeyboardListener):void {
			_keyboardListener = value;
			setupKeyboardListener(_keyboardListener);
		}
		
		public function get memorySecurity():Boolean { return _memorySecurity; }
		
		public function set memorySecurity(value:Boolean):void {
			_memorySecurity = value;
		}
		
		public function get memorySecurityMaxLines():int { return _memorySecurityMaxLines; }
		
		public function set memorySecurityMaxLines(value:int):void {
			_memorySecurityMaxLines = value;
		}
		
		public function get memorySecurityAutoClear():Boolean { return _memorySecurityAutoClear; }
		
		public function set memorySecurityAutoClear(value:Boolean):void {
			_memorySecurityAutoClear = value;
		}
		
		private function setupKeyboardListener(vK:KeyboardListener):void{
			vK.addEventListener(
				function (e:KeyboardEvent):void { debugMode = !debugMode; }, 
				new KeyboardEventMask(KeyboardEvent.KEY_DOWN, -1, 68, -1, 1)
			);
			//setting ctr+shift+D as default shortcut to clear the Debugger
			vK.addEventListener(
				function (e:KeyboardEvent):void { clear(); }, 
				new KeyboardEventMask(KeyboardEvent.KEY_DOWN, -1, 68, 1, 1)
			);
			//setting ctr+right guess the command
			vK.addEventListener(
				function (e:KeyboardEvent):void {
					var cmds:Array = _shell.dictionary.guess(_inputTxt.text);
					if (cmds.length > 0) {
						_inputTxt.text = cmds[0].name+_shell.parser.parameter_breaker;
						_inputTxt.setSelection(_inputTxt.length, _inputTxt.length);
					}
				}, 
				new KeyboardEventMask(KeyboardEvent.KEY_DOWN, -1, Keyboard.TAB,-1, -1)
			);
		}
		
		private function setupSell(vShell:Shell):void {
			//##################################
			vShell.dictionary.add(
				new CommandDefinition(
					"help"
					, function (a:Array):void { 
						printTitle("SHELL COMMANDS :");
						print("--> how to use ? \"commandName1, param1, param2...paramN;commandName2, param1, param2...paramN;(...)\"");
						print("--> you can omite the last command's \";\"");

						for each (var comdef:CommandDefinition in vShell.dictionary.commands) {
							print("- "+comdef.name + " : " + comdef.description);
						}
					  }
					, "display commands | params -> none | use -> help;"
				)
			);
			//##################################
			vShell.dictionary.add(
				new CommandDefinition(
					"clear" 
					, function (a:Array):void { clear(); }
					, "clear debugger | params -> none | use -> clear;"
				)
			);
			//##################################
			vShell.dictionary.add(
				new CommandDefinition(
					"omniscient" 
					, function (a:Array):void { 
						stage.addEventListener(
							MouseEvent.CLICK
							, function (e:MouseEvent):void { print("MOUSE CLICK : " + e.target + " | " + e); }
						);
						stage.addEventListener(
							KeyboardEvent.KEY_DOWN
							, function (e:KeyboardEvent):void { print("KEY DOWN : " + e.target + " | " + e); }
						);
					}
					, "listen major events on stage (MouseEvent.CLICK,KeyboardEvent.KEY_DOWN...) | params -> none | use -> omniscient;"
				)
			);
			
			
			
		}
		
	}
	
}