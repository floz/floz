package com.bigarobas.templates.website {
	import com.bigarobas.events.SuperEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class WebsiteEvent extends SuperEvent {
		
		public static const PAGE_CLOSED:String = "page_closed";
		public static const PAGE_OPENED:String = "page_opened";
		
		public function WebsiteEvent(vType:String, vContent:*=null, vBubble:Boolean=true,vCancelable:Boolean=true) {
			super(vType,vContent, vBubble, vCancelable);
		}
		
	}
	
}