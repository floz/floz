package com.bigarobas.ui.skin {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class ComponentSkin {
		
		protected var _defaultTextFormat:TextFormat;
		protected var _background:DisplayObject;
		protected var _foreground:DisplayObject;
		
		public function ComponentSkin() {
			_defaultTextFormat = new TextFormat();
			_background = new Sprite();
			_foreground = new Sprite();
		}
		
		public function get defaultTextFormat():TextFormat { return _defaultTextFormat; }
		
		public function set defaultTextFormat(value:TextFormat):void {
			_defaultTextFormat = value;
		}
		
		public function get background():DisplayObject { return _background; }
		
		public function set background(value:DisplayObject):void {
			_background = value;
		}
		
		public function get foreground():DisplayObject { return _foreground; }
		
		public function set foreground(value:DisplayObject):void {
			_foreground = value;
		}
		
	}
	
}