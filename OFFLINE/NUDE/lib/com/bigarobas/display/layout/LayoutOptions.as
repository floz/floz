package com.bigarobas.display.layout {
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public dynamic class LayoutOptions {
				
		protected var _mode:String = LayoutMode.FREE;
		
		protected var _fixedBoxSize:Boolean = false;
		protected var _forceBoxSize:Boolean = false;
		protected var _boxWidth:Number = 10;
		protected var _boxHeight:Number = 10;
		protected var _maxColomns:int = 5;
		protected var _maxRows:int = 5;
		
		protected var _spacingTop:Number = 0;
		protected var _spacingRight:Number = 0;
		protected var _spacingBottom:Number = 0;
		protected var _spacingLeft:Number = 0;
		
		protected var _align:String = LayoutAlign.NONE;
		
		protected var _layout:ILayout=null;
		
		public function LayoutOptions() {

		}
		
		public function get mode():String { return _mode; }
		
		public function set mode(value:String):void {
			_mode = value;
			update();
		}
		
		public function get spacings():Array { return [_spacingTop , _spacingRight , _spacingBottom , _spacingLeft]; }
		
		public function set spacings(value:Array):void {
			_spacingTop = value[0];
			_spacingRight = value[1];
			_spacingBottom = value[2];
			_spacingLeft = value[3];
			update();
		}
		
		public function set spacing(value:Number):void {
			_spacingTop = _spacingRight = _spacingBottom = _spacingLeft = value;
			update();
		}
		
		public function get fixedBoxSize():Boolean { return _fixedBoxSize; }
		
		public function set fixedBoxSize(value:Boolean):void {
			_fixedBoxSize = value;
			update();
		}
		
		public function get forceBoxSize():Boolean { return _forceBoxSize; }
		
		public function set forceBoxSize(value:Boolean):void {
			_forceBoxSize = value;
			update();
		}
		
		public function get maxColomns():int { return _maxColomns; }
		
		public function set maxColomns(value:int):void {
			_maxColomns = value;
			update();
		}
		
		public function get maxRows():int { return _maxRows; }
		
		public function set maxRows(value:int):void {
			_maxRows = value;
			update();
		}
		
		public function get boxWidth():Number { return _boxWidth; }
		
		public function set boxWidth(value:Number):void {
			_boxWidth = value;
			update();
		}
		
		public function get boxHeight():Number { return _boxHeight; }
		
		public function set boxHeight(value:Number):void {
			_boxHeight = value;
			update();
		}
		
		public function get layout():ILayout { return _layout; }
		
		public function set layout(value:ILayout):void {
			_layout = value;
		}
		
		public function get align():String { return _align; }
		
		public function set align(value:String):void {
			_align = value;
			update();
		}
		
		private function update():void {
			if (_layout != null) {
				_layout.rearrange();
			}
		}
		
		public function clone():LayoutOptions {
			var lp:LayoutOptions = new LayoutOptions();
			lp.mode = mode;
			lp.fixedBoxSize = fixedBoxSize;
			lp.forceBoxSize = forceBoxSize;
			lp.boxWidth = boxWidth;
			lp.boxHeight = boxHeight;
			lp.maxColomns = maxColomns;
			lp.maxRows = maxRows;
			lp.spacings = [_spacingTop, _spacingRight, _spacingBottom, _spacingLeft];
			return(lp);
		}
	}
	
}