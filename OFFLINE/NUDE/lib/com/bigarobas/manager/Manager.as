package com.bigarobas.manager {
	import flash.events.EventDispatcher;
	
	public class Manager extends EventDispatcher{
		
		protected var _members:Array;
		protected var _length:int = 0;

		public function Manager() {
			_members = [];
		}
		
		public function add(vMember:*):void {
			var member_id:int = getID(vMember);
			if (member_id == -1) {
				_members.push(vMember);
				_length = _members.length;
				dispatchEvent(new ManagerEvent(ManagerEvent.MEMBER_ADDED, vMember));
			}
		}
		
		public function remove(vMember:*):void {
			var member_id:int = getID(vMember);
			if (member_id != -1) {
				_members.splice(member_id, 1);
				_length = _members.length;
				dispatchEvent(new ManagerEvent(ManagerEvent.MEMBER_REMOVED, vMember));
			}
		}
		
		public function has(vMember:*):Boolean {
			return (getID(vMember) as Boolean);
		}
		
		public function getID(vMember:*):int {
			return (_members.indexOf(vMember));
		}
		
		public function apply(vF:Function):void {
			for (var i:int = 0; i < _length; i++) {
				vF(_members[i]);
			}
		}
		
		public function get length():int { return _length; }
		public function get members():Array { return _members; }
		
	}
	
}