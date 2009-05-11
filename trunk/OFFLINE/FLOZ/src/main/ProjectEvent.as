package main 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Floz
	 */
	public class ProjectEvent extends Event 
	{
		public static const PROJECT_SELECT:String = "project_select";
		
		private var _section:String;
		private var _title:String;
		
		public function ProjectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, section:String = null, title:String = null) 
		{ 
			this._section = section;
			this._title = title;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ProjectEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ProjectEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get section():String { return _section; }
		
		public function set section(value:String):void 
		{
			_section = value;
		}
		
		public function get title():String { return _title; }
		
		public function set title(value:String):void 
		{
			_title = value;
		}
		
	}
	
}