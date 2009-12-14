package com.bigarobas.ui {
	import com.bigarobas.display.layer.LayerAlign;
	import com.bigarobas.display.layer.LayerAlignMode;
	import com.bigarobas.ui.skin.ComponentSkin;
	import com.bigarobas.ui.skin.dark.ComponentSkinDark;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Button extends Component{
		protected var _label:Label;
		public function Button(vTitle:String = "", handler:Function = null, vWidth:Number = 0, vHeight:Number = 15) {
			
			buttonMode = true;
			
			width = vWidth;
			height = vHeight;
			
			//alignMode = LayerAlignMode.NORMAL;
			//align = LayerAlign.MIDDLE;
			
			_label = new Label("");
			_label.mouseEnabled = true;
			addChild(_label);
			
			if (handler != null) addEventListener(MouseEvent.CLICK, handler);
			addEventListener(ComponentEvent.VALUE_CHANGED, onValueChanged);
			
			value = vTitle;	
			
		}
		
		private function onValueChanged(e:ComponentEvent):void {
			redraw();
		}
		
		override protected function draw():void {
			
			/*
			if (_label.width > _forcedWidth) {
				_skin.background.width = _label.width+_paddingLeft+_paddingRight;	
			} else {
				_skin.background.width = _forcedWidth+_paddingLeft+_paddingRight;
			}
			
			if (_label.height > _forcedHeight) {
				_skin.background.height = _label.height+_paddingTop+_paddingBottom;
			} else {
				_skin.background.height = _forcedHeight+_paddingTop+_paddingBottom;
			}
			*/
			
			_skin.background.width = width;
			_skin.background.height = height;
			
			bg.addChild(_skin.background);
			addChild(_label);
			
			//fg.addChild(_skin.foreground);
			
		}
		
		public function set value(vText:String):void {
			_label.value = vText;
			dispatchEvent(new ComponentEvent(ComponentEvent.VALUE_CHANGED));
		}
		
		override public function set skin(value:ComponentSkin):void {
			_skin = value;
			_label.skin = _skin;
			_label.redraw();
			redraw();
		}
		
		
		
	}
	
}