package com.bigarobas.manager {
	import com.bigarobas.events.SuperEvent;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class ManagerEvent extends SuperEvent{
		public static const MEMBER_ADDED:String = "member_added";
		public static const MEMBER_REMOVED:String = "member_removed";
		public static const EMPTY:String = "manager_empty";
		
		public function ManagerEvent(vType:String, vContent:*=null, vBubble:Boolean=true,vCancelable:Boolean=true) {
			super(vType,vContent, vBubble, vCancelable);
		}
		
	}
	
}