package com.gobzlite.display 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author David Ronai
	 */
	public class AssetButton extends AbstractButton
	{
		private var _padding:int;
		private var d:DisplayObject;
		
		public function AssetButton(d:DisplayObject, padding:int) 
		{
			this.d = d;
			this.padding = padding;
			addChild( d );
		}
		
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill( 0, 0 );
			graphics.drawRect(0, 0, d.width + padding * 2, d.height + padding * 2);
			graphics.endFill();
		}
		
		public function dispose():void
		{
			graphics.clear();
			removeChild( d );
			d = null;
		}
		
		public function get padding():int { return _padding; }
		
		public function set padding(value:int):void 
		{
			d.x = value;
			d.y = value;
			_padding = value;
			
			draw();
		}
		
	}

}