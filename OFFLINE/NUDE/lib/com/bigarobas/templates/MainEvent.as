package com.bigarobas.templates {
	
	import com.bigarobas.events.SuperEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class MainEvent extends SuperEvent {
		public static const READY_TO_BUILD:String = "ready_to_build";
		public static const BUILT:String = "built";
		
		public function MainEvent(vType:String, vContent:*=null, vBubble:Boolean=true,vCancelable:Boolean=true) {
			super(vType,vContent, vBubble, vCancelable);
		}
		
	}
	
}