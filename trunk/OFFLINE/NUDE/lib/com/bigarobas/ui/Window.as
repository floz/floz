package com.bigarobas.ui {
	import com.bigarobas.display.layer.LayerAutoSize;
	import com.bigarobas.display.layer.LayerEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Window extends Component{
		protected var _label:Label;
		protected var _canvas:Canvas;
		protected var _opened:Boolean = true;
		public function Window(vTitle:String,vAutoSize:String=LayerAutoSize.AUTOSIZE,vW:Number=200,vH:Number=200) {
			_label = new Label();
			_canvas = new Canvas();
			_canvas.autoSize = vAutoSize;
			_canvas.padding = 5;
			autoSize = vAutoSize;
			super.addChild(_label);
			super.addChild(_canvas);
			
			_label.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void { stage.addEventListener(MouseEvent.MOUSE_MOVE, drag); } );
			_label.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void { stage.removeEventListener(MouseEvent.MOUSE_MOVE, drag); } );
			
			title = vTitle;
		}
		
		private function drag(e:MouseEvent):void {
			x = -mouseClickPoint.x+parent.mouseX;
			y = -mouseClickPoint.y+parent.mouseY;
		}
		
		override protected function draw():void {
			_label.bg.clear();
			//_label.bg.drawRect(_canvas.width, _label.height);
			_canvas.y = _label.height;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			return _canvas.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			return _canvas.removeChild(child);
		}
				
		override public function set title(value:String):void {
			super.title = title;
			_label.title = value;
			redraw();
		}
		
		override public function get autoSize():String { return _canvas.autoSize; }
		
		override public function set autoSize(value:String):void {
			_canvas.autoSize = value;
		}
		
		override public function set padding(value:Number):void {
			_canvas.padding = value;
		}
		
		override public function get paddings():Array { return _canvas.paddings; }
		
		override public function set paddings(value:Array):void {
			_canvas.paddings = value;
		}
		
		
	}
	
}