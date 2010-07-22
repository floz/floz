package com.isoo.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public class IsooEvent extends Event 
	{
		public static const CLICK:String = "case_click";
		
		private var _caseX:int;
		private var _caseY:int;
		
		public function IsooEvent(caseX:int, caseY:int,type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_caseX = caseX;
			_caseY = caseY;
		} 
		
		public override function clone():Event 
		{ 
			return new IsooEvent(_caseX, _caseY, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IsooEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get caseX():int { return _caseX; }		
		public function get caseY():int { return _caseY; }
		
	}
	
}