package com.bigarobas.display.layout.custom {
	import com.bigarobas.display.layer.LayerAutoSize;
	import com.bigarobas.display.layout.Layout;
	import com.bigarobas.display.layout.LayoutMode;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class HorizontalLayout extends Layout {
		
		public function HorizontalLayout (vWidth:Number = 0, vHeight:Number = 0) {
			
			width = vWidth;
			height = vHeight;
			
			layoutOptions.mode = LayoutMode.HORIZONTAL;
			
			if (vWidth != 0 || vHeight!=0) 
				autoSize = LayerAutoSize.CROP;
			
			
			
		}
		
	}
	
}