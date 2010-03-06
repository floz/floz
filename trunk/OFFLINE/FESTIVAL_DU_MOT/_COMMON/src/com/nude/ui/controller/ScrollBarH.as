package com.nude.ui.controller {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScrollBarH extends ScrollBar {
		
		public function ScrollBarH (b:DisplayObject, bg:DisplayObject) {
			super();
			_button.addChild(b);
			_background.addChild(bg);
			_pos_min = 0;
			_pos_max = _background.width - _button.width;
		}
		
		override protected function draw():void {
			super.draw();
			_button.x = _pos_min + _scroll * _pos_max;
		}
		
		override protected function onBoutonMove(e:MouseEvent):void {
			_button.x = _background.mouseX;
			if (_button.x < _pos_min) _button.x = _pos_min;
			if (_button.x > _pos_max) _button.x = _pos_max;
			_pos = _button.x;
			if (_liveChange) {
				calculateButtonScroll();
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		override protected function onBGClick(e:MouseEvent):void {
			_button.x = _background.mouseX;
			if (_button.x < _pos_min) _button.x = _pos_min;
			if (_button.x > _pos_max) _button.x = _pos_max;
			_pos = _button.x;
			calculateButtonScroll();
			dispatchEvent(new Event(Event.CHANGE));
		}	
	
		
		
	}

}