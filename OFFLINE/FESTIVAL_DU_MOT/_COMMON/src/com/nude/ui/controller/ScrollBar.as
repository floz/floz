package com.nude.ui.controller {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScrollBar extends Controller {
		
		protected var _scroll:Number = 0;
		protected var _value:Number = 0;
		
		protected var _min_value:Number = 0;
		protected var _max_value:Number = 1;
		
		protected var _pos:Number = 0;
		protected var _pos_min:Number = 0;
		protected var _pos_max:Number = 0;
		
		protected var _background:Sprite;
		protected var _button:Sprite;
		
		
		public function ScrollBar() {
			_background = new Sprite();
			addChild(_background);
			
			_button = new Sprite();			
			addChild(_button);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override protected function validate():void {
			calculateValue();
			super.validate();
		}
		
		protected function onRemovedToStage(e:Event):void {
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedToStage );
			
			_background.removeEventListener(MouseEvent.CLICK, onBGClick);
			_button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonDown);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedToStage, false, 0, true );
			
			_background.addEventListener(MouseEvent.CLICK, onBGClick);
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown);
		}
		
		protected function calculateValue():void {
			_value = _min_value + _scroll * _max_value;
		}
		
		protected function calculateValueScroll():void {
			_scroll = _value / _max_value  - _min_value;
		}
		
		protected function calculateButtonScroll():void {
			_scroll = (_pos - _pos_min) / (_pos_max - _pos_min);
		}
		
		protected function onButtonDown(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onBoutonMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onBoutonUp);
		}
		
		protected function onBoutonUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onBoutonMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onBoutonUp);
			calculateButtonScroll();
			validate();
		}
		
		protected function onBoutonMove(e:MouseEvent):void {
			//to override
		}
		
		protected function onBGClick(e:MouseEvent):void {
			//to override
		}	
		
		
		
		public function get value():Number { return _value; }
		
		public function set value(n:Number):void {
			if (_passive) {
				_value = n;
				if (_value > _max_value) _value = _max_value;
				if (_value < _min_value) _value = _min_value;
				calculateValueScroll();
				validate();
			}
		}
		
		public function get max_value():Number { return _max_value; }
		
		public function set max_value(value:Number):void {
			_max_value = value;
			calculateValue();
			calculateValueScroll();
			validate();
		}
		
		public function get min_value():Number { return _min_value; }
		
		public function set min_value(value:Number):void {
			_min_value = value;
			calculateValue();
			calculateValueScroll();
			validate();
		}
		
		public function get scroll():Number { return _scroll; }
		
		public function set scroll(value:Number):void {
			if (_passive) {
				_scroll = value;
				calculateValue();
				calculateValueScroll();
				validate();
			}
		}
			
		public function get pos_min():Number { return _pos_min; }
		
		public function set pos_min(value:Number):void {
			_pos_min = value;
		}
		
		public function get pos_max():Number { return _pos_max; }
		
		public function set pos_max(value:Number):void {
			_pos_max = value;
		}
		
	}

}