package com.bigarobas.ui {
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class Canvas extends Component {
		
		public function Canvas(vWidth:Number = 200, vHeight:Number = 200 ) {
			width = vWidth;
			height = vHeight;
			redraw();
		}
		
		override protected function draw():void {

		}
		
		
	}
	
}