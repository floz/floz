package com.bigarobas.display {
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Dummy extends Sprite {
		protected var _w:Number;
		protected var _h:Number;
		protected var g:Graphics;
		public function Dummy(vW:Number = 100, vH:Number = 100) {
			_w = vW;
			_h = vH;
			g = graphics;
			draw();
		}
		
		public function draw():void {
			g.clear();
			g.lineStyle(1,0x000000,1)
			g.beginFill(0x000000, 1);
			g.drawRect(0, 0, _w / 2, _h / 2);
			g.drawRect(_w / 2, _h / 2, _w / 2, _h / 2);
			g.endFill();
			g.beginFill(0xFFFF00, 1);
			g.drawRect(0, _h / 2, _w / 2, _h / 2);
			g.drawRect(_w / 2, 0, _w / 2, _h / 2);
			g.endFill();
		}
		
	}
	
}