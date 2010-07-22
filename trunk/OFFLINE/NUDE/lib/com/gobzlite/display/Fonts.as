package com.gobzlite.display 
{
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	/**
	 * Fonts register
	 * 
	 * ----------------
	 * + usage
	 * ----------------
	 * 
	 * Fonts.register(Futura, "Futura");
	 * var fontName:String = Fonts.getName("Futura");
	 * var font:Font = Fonts.getFont("Futura");
	 * 
	 */
	public class Fonts
	{
		
		static private var fonts:Dictionary = new Dictionary();
		
		public function Fonts() 
		{
			throw new Error("You can't create an instance of Fonts");
		}
		
		/**
		 * Register a font in application
		 * @param	font	class to register as font
		 * @param	id		define id of font , by default the id is the fontName
		 */
		static public function registerFont(font:Class, id:String=""):void
		{
			Font.registerFont(font);
			if ( id == "" )
				id = (new font() as Font).fontName;
			fonts[id] = new font();
			
		}
		
		/**
		 * Return fontName of the id
		 * @param	id
		 * @return
		 */
		static public function getName(id:String):String
		{
			if ( fonts[id] == undefined )
				return null;
			else 
				return (fonts[id] as Font).fontName;
		}
		
		/**
		 * Return the font associate with the id
		 * @param	id
		 * @return
		 */
		public static function getFont(id:String):Font
		{
			if ( fonts[id] == undefined )
				return null;
			else 
				return fonts[id] as Font;
		}
		
		public static function listFonts():void
		{
			trace( "Font list : " );
			var f:Font;
			var fonts:Array = Font.enumerateFonts();
			var i:int = fonts.length;
			while ( --i > -1 )
			{
				f = fonts[ i ];
				trace( "0: - fontname : " + f.fontName + ", fontStyle : " + f.fontStyle + ", fontType : " + f.fontType );
			}
		}

	}
	
}