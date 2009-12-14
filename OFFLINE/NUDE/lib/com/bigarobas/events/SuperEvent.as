package com.bigarobas.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */

	public class SuperEvent extends Event {
		protected var _content:*;
		public function SuperEvent(vType:String, vContent:*=null, vBubble:Boolean=true,vCancelable:Boolean=true) {
			super(vType, vBubble, vCancelable);
			_content = vContent;
		}
		public function get content():Object {
			return (_content);
		}
		
		public function set content(value:*):void {
			_content = value;
		}
	}
}