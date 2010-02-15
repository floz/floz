package com.nude.ui.graphic.shape {

	public class GCircle extends GShape{
		
		protected var _radius:Number = 0;
		
		public function GCircle(radius:Number=DEFAULT_SIZE,c:uint=DEFAULT_BACKGROUND_COLOR) {
			_radius = r;
			_color = c;
			redraw();
		}
		
		override protected function draw():void {
			super.draw();
			_g.drawCircle(0, 0, _radius);
		}
		
		public function get radius():Number { return _radius; }
		
		public function set radius(value:Number):void {
			_radius = value;
			redraw();
		}
		
		
	}

}