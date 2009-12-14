package com.bigarobas.superstatics {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class SuperDisplayObject {
		
		public static function getVisibleWidth(vD:DisplayObject):Number {
			var w:Number = 0;
			if (vD.mask) {
				var r:Rectangle = vD.getRect(vD).intersection(vD.mask.getRect(vD));
				w = r.width;
			} else {
				w = vD.width;
			}
			return (w);
		}
		
		public static function getVisibleHeight(vD:DisplayObject):Number {
			var h:Number = 0;
			if (vD.mask) {
				var r:Rectangle = vD.getRect(vD).intersection(vD.mask.getRect(vD));
				h = r.height;
			} else {
				h = vD.height;
			}
			return (h);
		}
		
		public static function getVisibleRect(vD:DisplayObject,vC:DisplayObject=null):Rectangle {
			var r:Rectangle;
			if (vC == null) vC = vD;
			if (vD.mask) {
				r = vD.getRect(vC).intersection(vD.mask.getRect(vC));
			} else {
				r = vD.getRect(vC);
			}
			return (r);
		}
		
		
		
	}
	
}