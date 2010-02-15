package com.nude.ui.controller {
	import com.nude.ui.Component;
	import flash.events.Event;

	public class Controller extends Component {
		
		protected var _passive:Boolean = true;
		protected var _liveChange:Boolean = true;
		protected var _onChange:Function;
		
		public function Controller() {
			buttonMode = true;
			_onChange = DEFAULT_CALLBACK;
			addEventListener(Event.CHANGE, onChangeHandler);
		}
		
		protected function onChangeHandler(e:Event):void {
			_onChange();
		}
		
		protected function validate():void {
			redraw();
			dispatchEvent(new Event(Event.CHANGE));
		}	
		
		public function get onChange():Function { return _onChange; }
		
		public function set onChange(f:Function):void {
			_onChange = f;
		}
		
		public function get liveChange():Boolean { return _liveChange; }
		
		public function set liveChange(value:Boolean):void {
			_liveChange = value;
		}
		
		
	}

}