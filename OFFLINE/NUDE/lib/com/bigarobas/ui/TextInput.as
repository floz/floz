package com.bigarobas.ui {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class TextInput extends Text{
		
		public function TextInput(vValue:String = "", vWidth:Number = 200, vHeight:Number = 100) {
			
			_textfield.type = TextFieldType.INPUT;
			_textfield.selectable = true;
			_textfield.multiline = true;
			_textfield.wordWrap = true;
			_textfield.width = vWidth;
			_textfield.height = vHeight;
			_firstValue = vValue;
			checkFocus = true;
			value = vValue;
			
		}
		
		override protected function draw():void {
			super.draw();
			addChild(_textfield);
			
			_skin.background.width =  width;
			_skin.background.height = height;
			
			_skin.foreground.width =  width;
			_skin.foreground.height = height;
			
			bg.addChild(_skin.background);
			fg.addChild(_skin.foreground);
		}
		
	}
	
}