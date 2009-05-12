
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
			_title.embedFonts = true;
			_title.styleSheet = Config.styleSheet;
			_title.filters = [ Config.glowFilter ];
			addChild( _title );
			
			_subTitle = new TextField();
			_subTitle.autoSize = TextFieldAutoSize.RIGHT;
			_subTitle.selectable = false;
			_subTitle.embedFonts = true;
			_subTitle.styleSheet = Config.styleSheet;
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
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( subTitle:String ):void
		{	
			//_title.embedFonts = true;
			//_title.styleSheet = Config.styleSheet;
			//_subTitle.embedFonts = true;
			//_subTitle.styleSheet = Config.styleSheet;
			
			_title.htmlText = "<span class='title_rubrique'>" + Config.currentSection.toUpperCase() + "</span>";
			_subTitle.htmlText = "<span class='lastprojects_preview_title'>" + subTitle.toUpperCase() + "</span>";
			
			_title.x = - _title.textWidth;
			_subTitle.x = - _subTitle.textWidth - 1;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}