package com.bigarobas.ui {
	import com.bigarobas.events.SuperEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class ComponentEvent extends SuperEvent{
		
		public static const DRAW:String = "component_draw";
		public static const VALUE_CHANGED:String = "component_value_changed";
		
		public function ComponentEvent(vName:String):void {
			super(vName,true,true);
		}
		
	}
	
}