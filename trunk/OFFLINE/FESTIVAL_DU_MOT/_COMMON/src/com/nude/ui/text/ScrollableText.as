package com.nude.ui.text {
	import com.nude.ui.controller.ScrollBar;

	public class ScrollableText extends Text {
		protected var _scrollV:ScrollBar;
		protected var _scrollH:ScrollBar;
		
		public function ScrollableText(w:Number=DEFAULT_SIZE,h:Number=DEFAULT_SIZE) {
			_width = w;
			_height = h;
		}
		
		public function get scrollV():ScrollBar { return _scrollV; }
		
		public function set scrollV(value:ScrollBar):void {
			_scrollV = value;
			_scrollV.onChange = DEFAULT_CALLBACK;
		}
		
		public function get scrollH():ScrollBar { return _scrollH; }
		
		public function set scrollH(value:ScrollBar):void {
			_scrollH = value;
			_scrollH.onChange = DEFAULT_CALLBACK;
		}
		
	}

}