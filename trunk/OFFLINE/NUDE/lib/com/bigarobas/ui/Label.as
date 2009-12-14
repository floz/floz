package com.bigarobas.ui {
	import com.bigarobas.display.layer.LayerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Label extends Text{
	
		public function Label(vValue:String = "", vWidth:Number = 0, vHeight:Number = 15) {
			
			if (vWidth!=0) {
				_textfield.autoSize = TextFieldAutoSize.NONE;
				_textfield.width = vWidth;
				_textfield.height = vHeight;

			} else {
				_textfield.autoSize = TextFieldAutoSize.LEFT;
			}
				
			_textfield.selectable = false;
			_textfield.multiline = false;
			_textfield.wordWrap = false;
			_textfield.mouseEnabled = false;
			
			value = vValue;
		}
		
		override protected function draw():void {
			super.draw();
		}
		
	}
	
}