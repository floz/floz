package com.bigarobas.templates {
	import com.bigarobas.device.keyboard.KeyboardEventMask;
	import com.bigarobas.device.keyboard.KeyboardListener;
	import com.bigarobas.display.layer.LayerAutoSize;
	import com.bigarobas.display.layout.Layout;
	import com.bigarobas.display.layout.LayoutMode;
	import com.bigarobas.net.loading.LoadingManager;
	import com.bigarobas.utils.command.CommandDefinition;
	import com.bigarobas.utils.command.Shell;
	import com.bigarobas.utils.command.TextLinkListener;
	import com.bigarobas.utils.debug.Debugger;
	import com.bigarobas.utils.language.ICosmopolite;
	import com.bigarobas.utils.language.LanguageManager;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TextEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class Main extends Layout implements ICosmopolite {
		
		public static var loader:LoadingManager;
		public static var debugger:Debugger;
		public static var shell:Shell;
		public static var languageManager:LanguageManager;
		public static var keyboardListener:KeyboardListener;
		public static var textlinkListener:TextLinkListener;
		
		public static var flashvars:Object;
		private static var _config:XML;
		
		//protected var _debugMode:Boolean = false;
		
		public function Main() {
			
			pre_init();
			init();
			post_init();
			addEventListener(MainEvent.READY_TO_BUILD, onReadyToBuild);
			
		}
		
		
		
		protected function init():void{
			analyseContexte();
			initStage();
			initStatics();
			initTemplate();
		}
		
		
		protected function pre_init():void { }
		protected function post_init():void { }
		protected function build():void { }
		
		private function onReadyToBuild(e:MainEvent):void {
			build();
			dispatchEvent(new MainEvent(MainEvent.BUILT));
		}
		
		//##################################################################################
		//##################################################################################
		//##################################################################################
		
		private function analyseContexte():void {
			flashvars = loaderInfo.parameters;
		}
		
		//##################################################################################
		//##################################################################################
		//##################################################################################
		
		private function initStatics():void{
			//a Shell can execute functions commandlines (you can setup its parser and commandDictionnary)
			shell = new Shell();
			//a simple texte Debugger (display it with ctr+D clear it with ctr+shift+D)
			debugger = new Debugger(stage, shell);
			//will execute commandlines dispatched with TextEvent.LINK and the "href=event:..." syntaxe
			textlinkListener = new TextLinkListener(stage, shell);
			textlinkListener.addEventListener(TextEvent.LINK, function(e:TextEvent):void { debugger.print(e); } );
			//creating the main LoadingManager which helps to easyly download and upload assets and data
			loader = new LoadingManager("Main.loader");
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void { onLoadingManagerIOError(e);} );
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, function(e:HTTPStatusEvent):void {onLoadingManagerHttpStatusOne(e);} );
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:SecurityErrorEvent):void {onLoadingManagerSecurityErrorOne(e);} );
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {onLoadingManagerComplete(e);} );

			//creating the keyboardListener witch can map keyboardEvents
			keyboardListener = new KeyboardListener(stage);
			//creating the languageManager
			languageManager = new LanguageManager();
			//registerToLanguageManager();
			
			createSpecificMainShellCommands();
			createSpecificMainKeyboardListeners();
		} 
		
		private function createSpecificMainShellCommands():void{
			
			shell.dictionary.add(
				new CommandDefinition(
					"padding"
					, function (a:Array):void { padding = a[0]; }
					, "change global padding | params -> globalPadding:Number | use -> padding,10;"
				)
			);
			
			shell.dictionary.add(
				new CommandDefinition(
					"paddings"
					, function (a:Array):void { paddings = a; }
					, "change specific paddings | params -> top:Number,right:Number,bottom:Number,left:Number | use -> paddings,5,10,3,10;"
				)
			);
			
			shell.dictionary.add(
				new CommandDefinition(
					"align"
					, function (a:Array):void { align = a[0]; }
					, "change align | use -> align,TR;"
				)
			);
			
			shell.dictionary.add(new CommandDefinition("setLanguage", function (a:Array):void { languageManager.setLanguage(a[0]); }, "setLangue,fr;") );

			
			
		}
		
		
		private function createSpecificMainKeyboardListeners():void{
			//esc -> display/hide the Debugger
			keyboardListener.addEventListener(
				function (e:KeyboardEvent):void { debugger.switchDisplay(); }, 
				new KeyboardEventMask(KeyboardEvent.KEY_DOWN, -1, Keyboard.ESCAPE)
			);
		}
		
		
		//##################################################################################
		//##################################################################################
		//##################################################################################
		
		protected function initStage():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			width = stage.stageWidth;
			height = stage.stageHeight;
		}
		//##################################################################################
		//##################################################################################
		//##################################################################################
		
		private function onLoadingManagerSecurityErrorOne(e:SecurityErrorEvent):void {
			debugger.error(this,loader, e);
		}
		
		private function onLoadingManagerHttpStatusOne(e:HTTPStatusEvent):void {
			debugger.print(this,loader, e);
		}
		
		private function onLoadingManagerIOError(e:IOErrorEvent):void {
			debugger.error(this,loader, e);
		}
		
		private function onLoadingManagerComplete(e:Event):void{
			debugger.print(this,loader, e);
		}
		
		//##################################################################################
		//##################################################################################
		//##################################################################################
		
		protected function initTemplate():void { }
		
		/* INTERFACE com.bigarobas.utils.language.ICosmopolite */
		
		public function translate():void{
			
		}
		
		public function registerToLanguageManager():void{
			languageManager.add(this);
		}
		
		public function set language(vLanguageID:String):void {
			languageManager.setLanguage(vLanguageID);
		}
		
		public function get language():String {
			return (languageManager.language);
		}
		
		static public function get config():XML { return _config; }
		
		static public function set config(value:XML):void {
			_config = value;
		}
	}
	
}