package com.bigarobas.display.layer {
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class LayerAbstractContainer extends Layer{
		protected var _child:DisplayObject;
		
		public function LayerAbstractContainer(vChild:DisplayObject = null) {
			if (vChild != null) {
				addChild(vChild);
				_child = vChild;
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			_content.addChild(child);
			dispatchEvent(new LayerEvent(LayerEvent.CONTENT_CHANGED));
			return(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			_content.removeChild(child);
			dispatchEvent(new LayerEvent(LayerEvent.CONTENT_CHANGED));
			return(child);
		}
		
		override public function removeChildAt(id:int):DisplayObject {
			var d:DisplayObject = _content.removeChildAt(id);
			dispatchEvent(new LayerEvent(LayerEvent.CONTENT_CHANGED));
			return(d);
		}
		
		override public function getChildAt(index:int):flash.display.DisplayObject {
			return _content.getChildAt(index);
		}
		
		override public function getChildByName(name:String):flash.display.DisplayObject {
			return _content.getChildByName(name);
		}
		
		override public function getChildIndex(child:flash.display.DisplayObject):int {
			return _content.getChildIndex(child);
		}
		
		override public function get numChildren():int {
			return (_content.numChildren);
		}
		
	}
	
}