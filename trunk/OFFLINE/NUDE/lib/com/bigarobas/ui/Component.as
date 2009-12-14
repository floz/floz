package com.bigarobas.ui {
	import com.bigarobas.display.layer.Layer;
	import com.bigarobas.ui.ComponentEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.TextFormat;
	import com.bigarobas.ui.skin.ComponentSkin;
	import com.bigarobas.ui.skin.default.ComponentSkinDefault;
	import com.bigarobas.ui.skin.dark.ComponentSkinDark;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class Component extends Layer {

		protected var _title:String = "";
		protected var _value:*= null;
		protected var _skin:ComponentSkin = new ComponentSkinDefault();
		

		public function Component() {
			padding = 1;
			addEventListener(ComponentEvent.DRAW, onDraw);
		}
		
		private function onDraw(e:Event):void {
			draw();
			redisplay();
		}
		
		public function redraw():void {
			dispatchEvent(new ComponentEvent(ComponentEvent.DRAW));
		}
		
		protected function draw():void {
			
		}
		
		public function get title():String { return _title; }
		
		public function set title(vTitle:String):void {
			_title = vTitle;
		}
		
		public function get skin():ComponentSkin { return _skin; }
		
		public function set skin(value:ComponentSkin):void {
			_skin = value;
			redraw();
		}
		
		
	}
	
}