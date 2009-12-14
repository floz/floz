package com.bigarobas.display.layer {
	import com.bigarobas.events.FullEventDispatcher;
	import com.bigarobas.superstatics.SuperDisplayObject;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class LayerContent extends FullEventDispatcher {
		protected var _layer:Layer;
		protected var _visibleWidth:Number = 0;
		protected var _visibleHeight:Number = 0;
		
		public function LayerContent(vLayer:Layer) {
			_layer = vLayer;
		}
		
		public function get layer():Layer { return _layer; }
		
		public function get visibleWidth():Number { 
			var nc:int = numChildren;
			if (nc > 0) {
				var r:Rectangle = getChildVisibleRectAt(0);
				var xmin:Number = r.x;
				var xmax:Number = r.x+r.width;
				for (var i:int = 1; i < nc; i++) {
					r = getChildVisibleRectAt(i);
					if (r.x < xmin) xmin = r.x;
					if ((r.x + r.width) > xmax) xmax = r.x + r.width;
				}
				_visibleWidth = xmax - xmin;
			}	
			
			return _visibleWidth; 
		}
		
		public function get visibleHeight():Number { 
			var nc:int = numChildren;
			if (nc > 0) {
				var r:Rectangle = getChildVisibleRectAt(0);
				var ymin:Number = r.y;
				var ymax:Number = r.y+r.height;
				for (var i:int = 1; i < nc; i++) {
						r = getChildVisibleRectAt(i);
						if (r.y < ymin) ymin = r.y;
						if ((r.y + r.height) > ymax) ymax = r.y + r.height;					
				}
				_visibleHeight = ymax - ymin;
			}
			
			return _visibleHeight; 
		}
		
		private function getChildVisibleRectAt(v:int):Rectangle {
			var child:DisplayObject = getChildAt(v);
			var layerChild:Layer;
			var r:Rectangle
			if (child is Layer) {
				layerChild = child as Layer;
				//r = layerChild.getVisibleRect();
				r = new Rectangle(layerChild.x, layerChild.y, layerChild.visibleWidth, layerChild.visibleHeight);
			} else {
				r = SuperDisplayObject.getVisibleRect(child, this);
			}
			return (r);
		}
	}
	
}