package com.gobzlite.display.ui 
{
	import com.gobzlite.utils.Color;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author David Ronai
	 */
	public class Progressbar extends Sprite
	{
		
		private var _width:int;
		private var _height:int;
		private var _progress:Number;
		
		public function Progressbar( width:int, height:int, colorBar:int=0x111111 ) 
		{
			_width = width;
			_height = height;
		}
		
		public function draw():void
		{
			graphics.beginFill(0);
			graphics.drawRect(0, 0, _width * _progress, 2);
			graphics.endFill();
		}
		
		public function get progress():Number { return _progress; }		
		public function set progress(value:Number):void 
		{
			_progress = value;
			draw();
		}
		
	}

}