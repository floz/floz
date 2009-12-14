package com.bigarobas.events {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class FullEventDispatcher extends Sprite{
		protected var _fullEventListenerList:Array;
		public function FullEventDispatcher() {
			_fullEventListenerList = [];
		}
		
		public function dispatchFullEvent(e:FullEvent):void {
			e.target = this;
			dipatchFullEventUp(e);	
		}
		
		public function dipatchFullEventDown(e:FullEvent):void {
			executeFullEvent(e);
			var nc:int = numChildren;
			for (var i:int = 0; i < nc; i++) {
				var child:DisplayObject = getChildAt(i);
				if (child is FullEventDispatcher) {
					(child as FullEventDispatcher).dipatchFullEventDown(e);
				} else {
					child.dispatchEvent(new Event(e.type, false, true));
				}
			}
		}
		
		private function executeFullEvent(e:FullEvent):void{
			if (_fullEventListenerList[e.type] is Function) {
				var evt:FullEvent = new FullEvent(e.type);
				evt.target = e.target;
				evt.currentTarget = this;
				_fullEventListenerList[e.type](evt);
			}
		}
		
		public function dipatchFullEventUp(e:FullEvent):void {
			if (parent is FullEventDispatcher) {
				(parent as FullEventDispatcher).dipatchFullEventUp(e);
			} else {
				dipatchFullEventDown(e);
			}
		}
		
		public function addFullEventListener(vType:String,vF:Function):void {
			_fullEventListenerList[vType] = vF;
		}
		public function removeFullEventListener(vType:String):void {
			_fullEventListenerList[vType] = null;
		}
		
	}
	
}