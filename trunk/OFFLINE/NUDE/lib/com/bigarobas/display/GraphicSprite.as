package com.bigarobas.display {
	import com.bigarobas.events.FullEventDispatcher;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class GraphicSprite extends FullEventDispatcher{
		
		
		protected var _fillColorDefault:uint = 0xCCCCCC;
		protected var _fillAlphaDefault:Number = 1;
		protected var _lineThickDefault:Number = 1;
		protected var _lineColorDefault:uint = 0x666666;
		protected var _lineAlphaDefault:Number = 1;
		
		protected var _fillColor:uint = _fillColorDefault;
		protected var _fillAlpha:Number = _fillAlphaDefault;
		protected var _lineThick:Number = _lineThickDefault;
		protected var _lineColor:uint = _lineColorDefault;
		protected var _lineAlpha:Number = _lineAlphaDefault;
		
		protected var _invisible:Boolean = false;
		
		protected var g:Graphics;
		
		public function GraphicSprite() {
			g = graphics;
		}
		
		public function clear():void {
			g.clear();
		}
		
		public function drawRect(vw:Number = 100, vh:Number = 100, vx:Number = 0, vy:Number = 0):void {
			g.clear();
			g.lineStyle(_lineThick, _lineColor, _lineAlpha);
			g.beginFill(_fillColor, _fillAlpha);
			g.drawRect(vx, vy, vw, vh);
			g.endFill();
		}
		
		public function drawGride(vW:Number = 100, vH:Number = 100, vWn:Number = 10, vHn:Number = 10):void {
			var w:Number = vW / vWn;
			var h:Number = vH / vHn;
			g.clear();
			g.lineStyle(1, 0xFF0000);
			for (var wi:int = 0; wi < vWn; wi++) {
				g.moveTo(w * wi , 0);
				g.lineTo(w * wi, vH);
			}
			
			for (var hi:int = 0; hi < vHn; hi++) {
				g.moveTo(0, h * hi);
				g.lineTo(vW, h * hi);
			}
		}
		
		public function get fillColor():uint { return _fillColor; }
		
		public function set fillColor(value:uint):void {
			_fillColor = value;
		}
		
		public function get fillAlpha():Number { return _fillAlpha; }
		
		public function set fillAlpha(value:Number):void {
			_fillAlpha = value;
		}
		
		public function get lineThick():Number { return _lineThick; }
		
		public function set lineThick(value:Number):void {
			_lineThick = value;
		}
		
		public function get lineColor():uint { return _lineColor; }
		
		public function set lineColor(value:uint):void {
			_lineColor = value;
		}
		
		public function get lineAlpha():Number { return _lineAlpha; }
		
		public function set lineAlpha(value:Number):void {
			_lineAlpha = value;
		}
		
	}
	
}