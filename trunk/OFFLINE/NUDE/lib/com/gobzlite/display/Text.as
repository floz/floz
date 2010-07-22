package com.gobzlite.display
{
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Improve Textfield for common usage.
	 * 
	 * ------------------
	 * + usage
	 * ------------------
	 * 
	 * - Make a simple text
	 * var text:Text = new Text( "Hello", 0xFF0000, 12, "arial" );
	 * 
	 * - Make css
	 * text.css = "h1";
	 * 
	 * - Create with css
	 * var text:Text = Text.factory( "helloCSS", "h1" );
	 * 
	 * 
	 * @author David Ronai
	 */
	public class Text extends TextField
	{
		// - STATIC VAR ------------------------------------------------------------------------------
		
		private static var _defaultFont:String = "_sans";
		
		
		// - PRIVATE VAR -----------------------------------------------------------------------------
		
		private var _css:String;
		private var _text:String;
		private var format:TextFormat;
		
		
		/**
		 * Create an textfield with specified propertie
		 * 
		 * @param	color Text color
		 * @param	size Font size
		 * @param	font Font name or if the string is empty select the font by default 
		 */
		public function Text( text:String = "", color:int = 0x000000, size:Number = 10, font:String = "", thickness:int = -200, sharpness:int = -200 ) 
		{
			if ( font == "" )
				font = _defaultFont;
			else
				embedFonts = true;
			
			format = new TextFormat(font, size, color);
			defaultTextFormat = format;
			mouseWheelEnabled = false;
			autoSize = TextFieldAutoSize.LEFT;
			selectable = false;
			
			thickness = thickness;
			sharpness = thickness;
			
			htmlText = text;
		}
		
		/**
		 * Embeded font  and add Anti Aliasing
		 */		
		override public function set embedFonts(value:Boolean):void 
		{
			super.embedFonts = value;
			if ( value )
				antiAliasType = AntiAliasType.ADVANCED;
			else
				antiAliasType = AntiAliasType.NORMAL;
		}
		
		/**
		 * Change leading
		 */
		public function set leading( value:Number ):void 
		{
			format.leading = value;
			defaultTextFormat = format;
			text = text;
		}
		
		
		/**
		 * Return the css class
		 */
		public function get css():String { return _css; }	
		
		/**
		 * set the css class
		 */
		public function set css(value:String):void 
		{
			_css = value;
			
			embedFonts = true;
			
			if( CSS.style != null )
				styleSheet = CSS.style;
				
			htmlText = _text; 
		}
		
		override public function set htmlText(value:String):void 
		{
			_text = value;
			if( _css!=null )
				super.htmlText = "<span class='" + _css + "' >" + _text + "</span>";
			else 
				super.htmlText = _text;
		}
		
		/**
		 * Change font by default
		 */
		static public function set defaultFont(value:String):void 
		{
			_defaultFont = value;
		}
		
		/**
		 * 
		 * @param	text
		 * @param	css
		 * @return
		 */
		static public function factory( text:String, css:String ):Text
		{
			var t:Text = new Text(text);
			t.css = css;
			return t;
		}
		
	}
	
}