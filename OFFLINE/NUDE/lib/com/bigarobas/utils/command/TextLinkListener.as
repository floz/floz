package com.bigarobas.utils.command {
	import com.bigarobas.templates.Main;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.events.EventDispatcher;
	import flash.events.TextEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class TextLinkListener extends EventDispatcher {
		protected var _proxy:EventDispatcher;
		protected var _shell:Shell;
		public function TextLinkListener(vProxy:EventDispatcher,vShell:Shell=null) {
			_proxy = vProxy;
			if (vShell == null) vShell = new Shell();
			_shell = vShell;
			_proxy.addEventListener(TextEvent.LINK, onTextLink);
		}
		
		private function onTextLink(e:TextEvent):void {
			if (e.target != this)	{
				_shell.execute(e.text);
				dispatchEvent(e);
			}
			
		}
		
		public function get shell():Shell { return _shell; }
		
		public function set shell(value:Shell):void {
			_shell = value;
		}
		
	}
	
}