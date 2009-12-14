package com.bigarobas.display.layout {
	import com.bigarobas.display.layer.ILayer;
	import com.bigarobas.display.layer.Layer;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Rashid Ghassempouri [www.bigarobas.com]
	 */
	public class LayoutArranger {
		
		protected static const _modes:Array = [		
			{mode:LayoutMode.FREE, f:onFree },
			{mode:LayoutMode.HORIZONTAL, f:onHorizontal },
			{mode:LayoutMode.VERTICAL, f:onVertical },
			{mode:LayoutMode.GRIDE, f:onGride },
			{mode:LayoutMode.CIRCLE, f:onFree },
			{mode:LayoutMode.CARROUSEL, f:onFree }

		];
		
		public static function arrange(vLayout:DisplayObjectContainer, vOptions:LayoutOptions):void {
			if (vOptions.forceBoxSize) {
				loop (vLayout,
				function (current:DisplayObject, i:int, last:DisplayObject, next:DisplayObject):void {
					current.width = vOptions.boxWidth;
					current.height = vOptions.boxHeight
				}
			);
			}
			_modes.forEach ( 
				function (element:*, index:int, arr:Array):void {
					if (element.mode == vOptions.mode) {
						element.f(vLayout,vOptions);
						if (vLayout is ILayout) {
							(vLayout as ILayout).redisplay();
						}
					}
				}
			);
        }
		
		public static function addMode(vKey:String, vFunction:Function):void {
			_modes.push ( { mode:vKey, f:vFunction } );
		}
		
		public static function loop(vLayout:DisplayObjectContainer, f:Function):void {
			var n:int = vLayout.numChildren;
			var last:DisplayObject = null;
			var next:DisplayObject = null;
			var current:DisplayObject = null;
			for (var i:int = 0; i < n; i++) {
				current = vLayout.getChildAt(i);
				if (i < n - 1) next = vLayout.getChildAt(i);
				else (next) = null;
				f(current, i, last, next);
				last = current;
			}
		}
		
		protected static function onFree(vLayout:DisplayObjectContainer,vOptions:LayoutOptions):void{
			loop (vLayout,
				function (current:DisplayObject, i:int, last:DisplayObject, next:DisplayObject):void {
					
				switch (vOptions.align) {
					case LayoutAlign.CENTER:
						current.x = ((vLayout.width - current.width) / 2);
						current.y = ((vLayout.height - current.height) / 2);
					break;
					default:
						//current.x = 0;
						//current.y = 0;
					break;
					
				}
					
				}
			);
		}
		
		protected static function onGride(vLayout:DisplayObjectContainer,vOptions:LayoutOptions):void {
			loop (vLayout,
				function (current:DisplayObject, i:int, last:DisplayObject, next:DisplayObject):void {
					var nc:int = (i % vOptions.maxColomns);
					var nr:int = Math.floor(i / vOptions.maxColomns);
					current.x = (vOptions.spacings[1]+vOptions.boxWidth) * nc;
					current.y = (vOptions.spacings[3]+vOptions.boxHeight) * nr;
				}
			);
		}
		
		protected static function onHorizontal(vLayout:DisplayObjectContainer,vOptions:LayoutOptions):void{
			loop (vLayout,
				function (current:DisplayObject, i:int, last:DisplayObject, next:DisplayObject):void {
					if (vOptions.fixedBoxSize) {
						current.x = (vOptions.spacings[1] + vOptions.boxWidth) * i;
						current.y = 0;
					} else {
						switch (vOptions.align) {
							case LayoutAlign.CENTER:
								current.y = ((vLayout.height - current.height) / 2);
							break;
							case LayoutAlign.BOTTOM:
								current.y = ((vLayout.height - current.height));
							break;
							default:
								current.y = 0;
							break;
							
						}
						if (last != null) {
							current.x = last.x + last.width + vOptions.spacings[1];
						}else {
							current.x = 0;
						}
					}
					
				}
			);
		}
		
		protected static function onVertical(vLayout:DisplayObjectContainer,vOptions:LayoutOptions):void{
			loop (vLayout,
				function (current:DisplayObject, i:int, last:DisplayObject, next:DisplayObject):void {
					if (vOptions.fixedBoxSize) {
						current.x = 0;
						current.y = (vOptions.spacings[3] + vOptions.boxHeight) * i;
					} else {
						switch (vOptions.align) {
							case LayoutAlign.CENTER:
								current.x = ((vLayout.width - current.width) / 2);
							break;
							case LayoutAlign.RIGHT:
								current.x = ((vLayout.width - current.width));
							break;
							default:
								current.x = 0;
							break;
							
						}
						if (last!=null){
							current.y = last.y + last.height + vOptions.spacings[3];
						}else {
							current.y = 0;
						}
						
					}
					
					
				}
			);
		}
		
	}
	
}