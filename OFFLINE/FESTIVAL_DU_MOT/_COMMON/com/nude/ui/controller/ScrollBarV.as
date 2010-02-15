package com.nude.ui.controller {
	
	import com.nude.ui.controller.ScrollBar;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScrollBarV extends ScrollBar {
		
		public function ScrollBarV (b:DisplayObject, bg:DisplayObject) {
			super();
			_button.addChild(b);
			_background.addChild(bg);
			_pos_min = 0;
			_pos_max = _background.height - _button.height;
		}
		
		override protected function draw():void {
			super.draw();
			_button.y = _pos_min + _scroll * _pos_max;
		}
		
		override protected function onBoutonMove(e:MouseEvent):void {
			_button.y = _background.mouseY;
			if (_button.y < _pos_min) _button.y = _pos_min;
			if (_button.y > _pos_max) _button.y = _pos_max;
			_pos = _button.y;
			if (_liveChange) {
				calculateButtonScroll();
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		override protected function onBGClick(e:MouseEvent):void {
			_button.y = _background.mouseY;
			if (_button.y < _pos_min) _button.y = _pos_min;
			if (_button.y > _pos_max) _button.y = _pos_max;
			_pos = _button.y;
			calculateButtonScroll();
			dispatchEvent(new Event(Event.CHANGE));
		}	
	
		
		
	}

}