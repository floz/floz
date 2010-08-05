
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package test_text 
{
	import assets.fonts.AssetHelveticaBlack;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fr.minuit4.net.loaders.DataLoader;
	import fr.minuit4.text.fontManager;
	import fr.minuit4.text.textManager;
	
	public class MainTestManagers extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestManagers() 
		{
			fontManager.registerFont( AssetHelveticaBlack );
			fontManager.traceFonts();
			
			initFormat();
			initCSS();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function styleCompleteHandler(e:Event):void 
		{
			var dataLoader:DataLoader = e.currentTarget as DataLoader;
			textManager.parseCSS( dataLoader.content );
			
			initCSSText();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initFormat():void
		{
			var format:TextFormat = new TextFormat( "HelveticaNeue-Black", 18, 0xffff00 );
			textManager.registerFormat( "default_format", format );
			
			initFormatText();
		}
		
		private function initFormatText():void		
		{
			var tf:TextField = new TextField();
			textManager.setText( tf, "HELLO WORLD", "default_format" );
			addChild( tf );
		}
		
		private function initCSS():void
		{
			var dataLoader:DataLoader = new DataLoader( "assets/css/style.css" );
			dataLoader.addEventListener( Event.COMPLETE, styleCompleteHandler, false, 0, true );
			dataLoader.load();
		}
		
		private function initCSSText():void
		{
			var tf:TextField = new TextField();
			textManager.setText( tf, "HELLO WORLD", "default_css" );
			tf.y = 50;
			addChild( tf );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}