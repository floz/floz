package com.nude.ui.graphic.shape {
	
	import com.nude.ui.Component;
	import flash.display.Graphics;
	
	public class GShape extends Component {
				
		public static const FILL_MODE:String = "gshape_mode_fill";
		public static const LINE_MODE:String = "gshape_mode_line";
		public static const FULL_MODE:String = "gshape_mode_full";

		protected var _mode:String = FILL_MODE;
		
		protected var _g:Graphics;
		protected var _color:uint = DEFAULT_BACKGROUND_COLOR;
		protected var _lineColor:uint = DEFAULT_FOREGROUND_COLOR;
		
		public function GShape() {
			_g = this.graphics;	
		}
		
		override protected function draw():void {}
		
		override public function redraw():void {
			
			_g.clear();
			
			switch (_mode) {
				case FILL_MODE: _g.beginFill(_color, 1); break;
				case LINE_MODE: _g.lineStyle(1, _color, 1); break;
				case FULL_MODE: _g.lineStyle(1, _lineColor, 1);	_g.beginFill(_color, 1); break;
			}
			
			draw();
			
			switch (_mode) {
				case FILL_MODE: _g.endFill(); break;
				case LINE_MODE:	break;
				case FULL_MODE:	_g.endFill(); break;
			}
			
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void { 
			_color = value; 
			redraw(); 
		}
		
		public function drawRect(w:Number = DEFAULT_SIZE, h:Number = DEFAULT_SIZE,c:uint=DEFAULT_BACKGROUND_COLOR):void {
			_g.clear();
			_g.beginFill(c, 1);
			_g.drawRect(0, 0, w, h);
			_g.endFill();
		}
		
		public function drawCircle(r:Number = DEFAULT_SIZE, c:uint=DEFAULT_BACKGROUND_COLOR):void {
			_g.clear();
			_g.beginFill(c, 1);
			_g.drawCircle(0, 0, r);
			_g.endFill();
		}
		
	}

}