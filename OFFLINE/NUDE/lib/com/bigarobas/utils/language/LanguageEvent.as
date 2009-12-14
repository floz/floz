package com.bigarobas.utils.language {
	
	import com.bigarobas.events.SuperEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	
	public class LanguageEvent extends SuperEvent {
		public static const CHANGE_LANGUAGE:String = "change_language";
		public static const LANGUAGE_CHANGED:String = "language_changed";
		
		public function LanguageEvent(vType:String, vContent:*=null, vBubble:Boolean=true,vCancelable:Boolean=true) {
			super(vType,vContent, vBubble, vCancelable);
		}
		
	}
	
}