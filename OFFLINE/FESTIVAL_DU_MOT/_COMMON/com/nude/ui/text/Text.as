/**
 | N U D E
 | The low dependent flash oriented framework
 |
 | Copyright © 2009		> MIT license 					> http://www.opensource.org/licenses/mit-license.php
 | Florian Zumbrunn		> florian.zumbrunn@gmail.com	> http://www.floz.fr
 | Arnaud Nicolas		> arno06@gmail.com				> 
 | Rashid Ghassempouri	> rashid.ghassempouri@gmail.com	> http://www.bigarobas.com
 */

package com.nude.ui.text {
	
	/**
	* 	What a Text should be ^^
	* 	@langversion ActionScript 3.0
	*/
	
	import com.nude.ui.Component;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Text extends Component {
		
		protected var _value:String;
		protected var _textfield:TextField;
		protected var _format:TextFormat = DEFAULT_TEXTFORMAT;
		protected var _html:Boolean = true;
		
		public function Text() {
			_textfield = new TextField();
			_textfield.defaultTextFormat = _format;
			_textfield.autoSize = TextFieldAutoSize.LEFT;
			_textfield.wordWrap = true;
			_textfield.multiline = true;
			addChild(_textfield);
		}
		
		override protected function draw():void {
			super.draw();
			if (_html) _textfield.htmlText = _value;
			else _textfield.text = _value;
		}
		
		public function get value():String { return _value; }
		
		public function set value(value:String):void {
			_value = value;
			dispatchEvent(new Event(Event.CHANGE));
			redraw();
		}
		
		public function get format():TextFormat { return _format; }
		
		public function set format(value:TextFormat):void {
			_format = value;
			_textfield.defaultTextFormat = _format;
			redraw();
		}
		
		public function get html():Boolean { return _html; }
		
		public function set html(value:Boolean):void {
			_html = value;
		}
		
	}

}