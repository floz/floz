package com.nude.ui.miscellaneous {
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class Dummy extends Sprite {
		
		public function Dummy(w:Number = 100, h:Number = 100) {
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(1,0x000000,1)
			g.beginFill(0x000000, 1);
			g.drawRect(0, 0, w / 2, h / 2);
			g.drawRect(w / 2, h / 2, w / 2, h / 2);
			g.endFill();
			g.beginFill(0xFFFF00, 1);
			g.drawRect(0, h / 2, w / 2, h / 2);
			g.drawRect(w / 2, 0, w / 2, h / 2);
			g.endFill();
		}
		
	}
	
}