
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Title extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _title:TextField;
		private var _subTitle:TextField;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Title() 
		{
			_title = new TextField();
			_title.autoSize = TextFieldAutoSize.RIGHT;
			_title.selectable = false;
			_title.filters = [ Config.glowFilter ];
			addChild( _title );
			
			_subTitle = new TextField();
			_subTitle.autoSize = TextFieldAutoSize.RIGHT;
			_subTitle.selectable = false;
			_subTitle.y = 37;
			var glowFilter:GlowFilter = Config.glowFilter.clone() as GlowFilter;
			glowFilter.strength = 2.2;
			_subTitle.filters = [ glowFilter ];
			addChild( _subTitle );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getTextFormat( fontName:String, fontSize:int, fontColor:uint, bold:Boolean = false ):TextFormat
		{
			var tf:TextFormat = new TextFormat( fontName, fontSize, fontColor );
			tf.align = TextFormatAlign.RIGHT;
			tf.bold = bold;
			
			return tf;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( subTitle:String ):void
		{
			_title.text = Config.currentSection.toUpperCase();
			_subTitle.text = subTitle.toUpperCase();
			
			_title.x = - _title.textWidth;
			_subTitle.x = - _subTitle.textWidth - 1;
			
			_title.setTextFormat( getTextFormat( Config.fonts.getItemLoaded().futuraMedium.fontName, 36, 0xb4c59c, true ) );
			_subTitle.setTextFormat( getTextFormat( Config.fonts.getItemLoaded().futuraLight.fontName, 14, 0xffffff ) );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}