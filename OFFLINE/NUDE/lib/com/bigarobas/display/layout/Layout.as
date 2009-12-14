package com.bigarobas.display.layout {
	import com.bigarobas.display.layer.Layer;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Layout extends Layer implements ILayout {
		
		protected var _layoutOptions:LayoutOptions = new LayoutOptions();
		protected var _needArrange:Boolean = false;
		
		public function Layout(vOptions:LayoutOptions = null) {
			if (vOptions!=null) {
				_layoutOptions = vOptions.clone();
				_layoutOptions.layout = this;
			} else {
				_layoutOptions = new LayoutOptions();
				_layoutOptions.layout = this;
			}
			needArrange = true;
			
		}
		
		private function onEnterFrameArrange(e:Event):void {
			arrange();
			needArrange = false;
		}
		
		public function rearrange():void {
			needArrange = true;
		}
		
		public function arrange():void {
			LayoutArranger.arrange(this, layoutOptions);
			needRedisplay = true;
		}
		
		public function get layoutOptions():LayoutOptions { return _layoutOptions; }
		
		public function set layoutOptions(value:LayoutOptions):void {
			_layoutOptions = value;
			_layoutOptions.layout = this;
			needArrange = true;
		}
		
		public function get needArrange():Boolean { return _needArrange; }
		
		public function set needArrange(value:Boolean):void {
			_needArrange = value;
			if (_needArrange) {
				addEventListener(Event.ENTER_FRAME, onEnterFrameArrange);
			} else {
				removeEventListener(Event.ENTER_FRAME, onEnterFrameArrange);
			}
		}
		
		
		override public function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			//_needArrange = true;
			arrange();
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			super.removeChild(child);
			//_needArrange = true;
			arrange();
			return child;
		}
		
		override public function removeChildAt(id:int):DisplayObject {
			var child:DisplayObject = super.removeChildAt(id);
			//_needArrange = true;
			arrange();
			return child;
		} 
	
		
	}
	
}