package com.nude.ui.graphic.gui.controller {
	
	import com.nude.ui.controller.ScrollBarV;
	import com.nude.ui.graphic.shape.GRectangle;
	import com.nude.ui.graphic.shape.GSquare;

	public class GScrollBarV extends ScrollBarV {
		
		public function GScrollBarV (w:Number=10,h:Number=200,btc:uint=DEFAULT_FOREGROUND_COLOR,bgc:uint=DEFAULT_BACKGROUND_COLOR) {
			super(new GSquare(w,btc),new GRectangle(w,h,bgc));
		}	
		
	}

}