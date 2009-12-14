package com.bigarobas.display.layer {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class LayerEvent extends Event {
		
		public static const CONTENT_CHANGED:String = "layer_content_changed";
		
		public static const SIZE:String = "layer_size";
		public static const SIZED:String = "layer_sized";
		
		public static const PLACE:String = "layer_place";
		public static const PLACED:String = "layer_placed";
		
		public static const MOVED:String = "layer_moved";
		
		public static const DISPLAYED:String = "layer_displayed";
		
		public function LayerEvent(vName:String):void {
			super(vName,true,true);
		}
	}
	
}