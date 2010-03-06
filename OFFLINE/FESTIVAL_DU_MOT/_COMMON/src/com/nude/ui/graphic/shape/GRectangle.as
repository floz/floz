package com.nude.ui.graphic.shape {

	public class GRectangle	extends GShape{
		
		public function GRectangle(w:Number=DEFAULT_SIZE,h:Number=DEFAULT_SIZE/2,c:uint=DEFAULT_BACKGROUND_COLOR) {
			_width= w;
			_height = h;
			_color = c;
			redraw();
		}
		
		override protected function draw():void {
			super.draw();
			_g.drawRect(0, 0, _width, _height);
		}
		
		
	}

}