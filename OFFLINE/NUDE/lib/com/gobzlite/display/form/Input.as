package com.gobzlite.display.form 
{
	import assets.ShadowAsset;
	import com.gobzlite.display.Text;
	import com.gobzlite.utils.FormChecker;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * Create an text format to display as input
	 * @author David Ronai
	 */
	public class Input extends Text implements IFormComponent
	{
		
		private var _require:Boolean;
		private var _min:uint;
		private var _max:uint;
		private var _mail:Boolean;
		
		/**
		 * Create an input
		 * @param	text
		 * @param	color
		 * @param	size
		 * @param	font
		 */
		public function Input(text:String = "", color:int = 0x000000, size:Number = 10, font:String = "")
		{
			super(text, color, size, font);
			
			autoSize = TextFieldAutoSize.NONE;
			
			type = TextFieldType.INPUT;
			
			background = true;
			backgroundColor = 0xFAFAFA;
			
			border = true;
			borderColor = 0xCCCCCC;
			
			selectable = true;
			
			width = 120;
			height = 18;
			
			max( 32 );
			min( 0 );
			
			addEventListener( MouseEvent.CLICK, firstClickHandler );
		}
		
		/**
		 * Create an input
		 * @param	text
		 * @param	color
		 * @param	size
		 * @param	font
		 * @return
		 */
		public static function create(text:String = "", color:int = 0x000000, size:Number = 10, font:String = "") :Input
		{
			var input:Input = new Input( text, color, size, font );
			return input;
		}
		
		private function firstClickHandler(e:MouseEvent):void 
		{
			removeEventListener( MouseEvent.CLICK, firstClickHandler );
			text = "";
		}
		
		public function get value():String
		{
			return text;
		}
		
		public function require(value:Boolean):IFormComponent
		{
			_require = value;
			return this;
		}
		
		/**
		 * Check if component is valid
		 * @return true if component is valid, else false
		 */
		public function isValid():Boolean
		{
			if ( length < _min || length > _max )
				return false;
			if ( _mail && !FormChecker.isValidEmail(text) )
				return false;
				
			return true;
		}
		
		/**
		 * Display input as password
		 * @param	value if true display as password , else false 
		 * @return the input
		 */
		public function password(value:Boolean):Input
		{
			displayAsPassword = value;
			return this;
		}
		
		/**
		 * Min lenght
		 * @param	value min lenght
		 * @return the input
		 */
		public function min(value:uint):Input
		{
			_min = value;
			return this;
		}

		/**
		 * Max lenght
		 * @param	value max lenght
		 * @return the input
		 */
		public function max(value:uint):Input
		{
			_max = value;
			maxChars = value;
			
			return this;
		}

		/**
		 * If component is a mail
		 * @param	value true if component should be formatted as a mail, else false
		 * @return the input
		 */
		public function mail(value:Boolean):Input
		{
			_mail = value;
			return this;
		}
		
	}

}