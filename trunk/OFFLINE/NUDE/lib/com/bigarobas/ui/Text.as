package com.bigarobas.ui {
	import com.bigarobas.ui.skin.ComponentSkin;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Text extends Component{
		protected var _textfield:TextField;
		protected var _textfieldType:String = TextFieldType.DYNAMIC;
		protected var _firstValue:String = "";
		protected var _checkFocus:Boolean = false;
		
		public function Text(vValue:String="") {
			
			_textfield = new TextField();
			_textfield.type = _textfieldType;
			_textfield.defaultTextFormat = _skin.defaultTextFormat;
			
			_textfield.addEventListener(TextEvent.TEXT_INPUT, onTextInput);
			
			value = vValue;
			_firstValue = vValue;
			addChild(_textfield);
			
		}
		
		private function onTextInput(e:TextEvent):void {
			redraw();
		}
		
		override protected function draw():void {
			_textfield.htmlText = _textfield.htmlText;
		}
		
		public function set value(vText:String):void {
			_textfield.htmlText = vText;
			dispatchEvent(new ComponentEvent(ComponentEvent.VALUE_CHANGED));
			redraw();
		}
		
		public function get value():String {
			return (_textfield.text)
		}
		
		public function get textfield():TextField { return _textfield; }
				
		override public function set skin(value:ComponentSkin):void {
			_skin = value;
			_textfield.defaultTextFormat = _skin.defaultTextFormat;
			redraw();
		}
		
		public function get firstValue():String { return _firstValue; }
		
		public function set firstValue(value:String):void {
			_firstValue = value;
		}
		
		public function get checkFocus():Boolean { return _checkFocus; }
		
		public function set checkFocus(value:Boolean):void {
			_checkFocus = value;
			if (_checkFocus) {
				addEventListener(FocusEvent.FOCUS_IN, function(e:FocusEvent):void { if (_textfield.text == firstValue) _textfield.text = ""; } );
				addEventListener(FocusEvent.FOCUS_OUT, function(e:FocusEvent):void { if (_textfield.text == "") _textfield.text = firstValue; } ) ;
			}
		}
		
	}
	
}