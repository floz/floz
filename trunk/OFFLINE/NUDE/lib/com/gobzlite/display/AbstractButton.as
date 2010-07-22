package com.gobzlite.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * Abstract button. 
	 * 
	 * -------------------
	 * + usage 
	 * -------------------
	 * 
	 * btn.group = "groupName";
	 * btn.selected = true||false;
	 * 
	 * 
	 * -------------------
	 * + sample
	 * -------------------
	 * 
	 * for ( var i:int = 0; i < 10; i++){
	 * 		var btn:AbstractButton = new TestButton();
	 *		btn.group = "navigation";
	 *	 	btn.addEventListener(MouseEvent.CLICK, onClick );
	 *		addChild( btn );
	 *	}
	 *
	 * private function onClick(e:Event):void {
	 * 		// auto unselect other group button.
	 * 		e.target.selected = true;
	 * }
	 * 
	 * -------------------
	 * + todo
	 * -------------------
	 * 
	 * btn.enabled = true || false;
	 * AbstractButton.enabledGroup( groupName:String, enabled );
	 * 
	 * 
	 * 
	 * @version 0.3 : add pressMode & onRollOutSelected/onRollOverSelected
	 * @version 0.2 : add group functionnality
	 * 
	 * @author David Ronai
	 */
	public class AbstractButton extends Sprite
	{
		
		// - STATIC VAR 
		
		private static var _buttons:Vector.<AbstractButton> = new Vector.<AbstractButton>();
		
		// - PRIVATE VAR 
		
		private var _group:String; 
		private var _selected:Boolean;
		private var _enabled:Boolean;
		private var _pressMode:Boolean;
		
		// - CONSTRUCTOR 
		
		public function AbstractButton() 
		{
			_group = "";
			_enabled = true;
			_selected = false;
			_pressMode = true;
			
			mouseChildren = false;
			buttonMode = true;
			
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		}
		
		// - HANDLERS 
		
		private function rollOutHandler(e:Event):void 
		{ 
			if ( !enabled )
				return;
			if ( selected ) {
				if ( _pressMode )
					return;
				else 
					onRollOutSelected();
			}
			else onRollOut();
		}	
		private function rollOverHandler(e:Event):void 
		{
			if ( !enabled )
				return;
			if ( selected ) {
				if ( _pressMode )
					return;
				else 
					onRollOverSelected();
			}
			else onRollOver();
		}
		
		protected function onRollOver():void{ }
		protected function onRollOut():void { }
		protected function onRollOverSelected():void { onRollOver(); }
		protected function onRollOutSelected():void { onRollOut(); }
		
		// - GETTERS AND SETTERS 
		
		public function get group():String { return _group; }
		
		public function set group(value:String):void 
		{
			_group = value;
			
			var index:int = _buttons.indexOf(this);
			
			if ( _group == "" ) {
				if ( index != -1 )
					_buttons.splice(index, 1);
			} else if( index == -1 ){
				_buttons.push( this );
			}			
		}
		
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void 
		{
			if ( value ) {
				if ( !_selected)
					onRollOver();
				if ( group != "" ) {
					for ( var i:int=0; i < _buttons.length; i++) {
						if ( _buttons[i].group == _group && _buttons[i]!= this) {
							_buttons[i].selected = false;
						}
					}
				}
			} else if( !value && _selected ) {
				onRollOut();
			}
			
			_selected = value;
			
		}		
		
		public function get pressMode():Boolean { return _pressMode; }		
		
		public function set pressMode(value:Boolean):void 
		{
			_pressMode = value;
		}
		
		public function get enabled():Boolean { return _enabled; }
		
		public function set enabled(value:Boolean):void 
		{
			buttonMode = value;
			_enabled = value;
		}
	}	
}