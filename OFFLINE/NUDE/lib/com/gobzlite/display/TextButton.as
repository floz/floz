package com.gobzlite.display 
{
	import flash.text.TextField;
	
	/**
	 * Create an text with clickable zone
	 * 
	 */
	public class TextButton extends AbstractButton
	{
		private var _text:TextField;
		private var _padding:int;
		
		/**
		 * Add Clickable zone to a textField
		 * @param	textField textField to add to the textButton
		 * @param	padding padding for the textfield
		 */
		public function TextButton( tf:TextField, padding:int = 2 ) 
		{
			_text = tf;
			addChild( _text );
			
			this.padding = padding;
		}
		
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill( 0, 0 );
			graphics.drawRect(0, 0, text.width + padding * 2, text.height + padding * 2);
			graphics.endFill();
		}
		
		public function dispose():void
		{
			graphics.clear();
			removeChild( _text );
			_text = null;
		}
		
		public function get text():TextField { return _text; }
		
		public function get padding():int { return _padding; }
		
		public function set padding(value:int):void 
		{
			_text.x = value;
			_text.y = value;
			_padding = value;
			
			draw();
		}
		
	}
	
}