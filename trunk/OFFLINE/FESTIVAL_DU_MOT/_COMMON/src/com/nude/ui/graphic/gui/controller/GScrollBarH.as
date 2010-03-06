package com.nude.ui.graphic.gui.controller {
	
	import com.nude.ui.controller.ScrollBarH;
	import com.nude.ui.graphic.shape.GRectangle;
	import com.nude.ui.graphic.shape.GSquare;

	public class GScrollBarH extends ScrollBarH {
		
		public function GScrollBarH (w:Number=200,h:Number=10,btc:uint=DEFAULT_FOREGROUND_COLOR,bgc:uint=DEFAULT_BACKGROUND_COLOR) {
			super(new GSquare(h,btc),new GRectangle(w,h,bgc));
		}
		
		
	}

}