package com.gobzlite.net.amfphp
{
	import flash.events.Event;
	
	/**
	 * Amfphp Query result
	 * @author David Ronai
	 */
	public class AmfphpEvent extends Event 
	{
		public static const RESULT:String 	= "result";
		public static const ERROR:String 	= "error";
		
		private var _result:Object;
		private var _success:Boolean;
		
		public function AmfphpEvent(type:String, result:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			_result = result;
			_success = ( type == RESULT );				
		} 

		public override function clone():Event 
		{ 
			return new AmfphpEvent(type, _result, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AmfphpEvent", "type", "result", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get result():Object { return _result; }
		public function get xmlResult():Object { return new XML(_result); }
		
		public function get success():Boolean { return _success; }		
	}
	
}