package com.nude.ui.graphic.gui {
	import com.nude.ui.Button;
	import com.nude.ui.graphic.shape.GRectangle;
	import com.nude.ui.text.Label;
	import flash.text.TextField;

	
	public class GButton extends Button{
		private var _label:Label;
		
		public function GButton(t:String = "",fc:Function= DEFAULT_CALLBACK) {
			_label = new Label(t);
			addChild(new GRectangle(_label.width,_label.height));
			super(_label, fc);
		}
		
	}

}