package com.gobzlite.display.form 
{
	import com.gobzlite.display.Text;
	import com.gobzlite.utils.align;
	import com.gobzlite.utils.align.Align;
	import com.gobzlite.utils.FormChecker;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * Create an text format to display as input
	 * @author David Ronai
	 */
	public class InputV2 extends Sprite 
	{
		private var t:Text;
		private var background:Shape;
		private var _min:int;
		private var _max:int;
		
		/**
		 * Create an input
		 * @param	text
		 * @param	color
		 * @param	size
		 * @param	font
		 */
		public function InputV2(text:String = "", color:int = 0x000000, size:Number = 10, font:String = "", padding:int=5, bgColor:int=0xFFFFFF,borderColor:int=0xCCCCCC )
		{
			t = new Text(text, color, size, font);
			addChild( t );
			t.type = TextFieldType.INPUT;			
			t.selectable = true;
			
			background = new Shape();
			background.graphics.beginFill( bgColor );
			background.graphics.lineStyle( 1, borderColor );
			background.graphics.drawRect(0, 0, 120 + padding * 2, t.height + padding * 2);
			background.graphics.endFill();
			addChildAt( background, 0 );
			
			t.autoSize = TextFieldAutoSize.NONE;
			t.width = 120;
			t.x = t.y = padding;
			
			max( 8 );
			min( 0 );
			
			addEventListener( MouseEvent.CLICK, firstClickHandler );
		}
		
		private function firstClickHandler(e:MouseEvent):void 
		{
			removeEventListener( MouseEvent.CLICK, firstClickHandler );
			t.text = "";
		}
		
		public function get value():String
		{
			return t.text;
		}
		
		/**
		 * Check if component is valid
		 * @return true if component is valid, else false
		 */
		public function isValid():Boolean
		{
			if ( t.length < _min || t.length > _max )
				return false;
			
			return true;
		}
		
		/**
		 * Min lenght
		 * @param	value min lenght
		 * @return the input
		 */
		public function min(value:uint):InputV2
		{
			_min = value;
			return this;
		}

		/**
		 * Max lenght
		 * @param	value max lenght
		 * @return the input
		 */
		public function max(value:uint):InputV2
		{
			_max = value;
			t.maxChars = value;
			
			return this;
		}
		
		public function get text():String
		{
			return t.text;
		}
	}

}