
/**
 * @author Floz
 */
package test_text 
{
	import assets.fonts.AssetHelveticaBlack;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import fr.minuit4.net.loaders.DataLoader;
	import fr.minuit4.text.managers.fontManager;
	import fr.minuit4.text.managers.textManager;
	import fr.minuit4.text.styles.AdvancedStyleSheet;
	import fr.minuit4.text.Text;

	public class MainTestStylesheet extends Sprite
	{		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dataLoader:DataLoader;
		private var _css:StyleSheet;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestStylesheet() 
		{
			fontManager.registerFont( AssetHelveticaBlack );
			fontManager.traceFonts();
			
			_dataLoader = new DataLoader();
			_dataLoader.addEventListener( Event.COMPLETE, dataCompleteHandler, false, 0, true );
			_dataLoader.load( "assets/css/advancedStyle.css" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function dataCompleteHandler(e:Event):void 
		{
			_css = new StyleSheet();
			_css.parseCSS( _dataLoader.content );
			
			initNativeText();
			initAdvancedStyleSheet();
			
			// Pour fonctionner :
			textManager.registerCSS( _css );
			// Puis
			initTextManager();			
			initText();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initNativeText():void
		{
			var tf:TextField = new TextField();
			tf.styleSheet = _css;
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.selectable = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.htmlText = "<span class='default'>HELLO WORLD</span>";
			tf.textColor = 0x000000;
			addChild( tf );
		}
		
		private function initAdvancedStyleSheet():void
		{
			var advancedCSS:AdvancedStyleSheet = new AdvancedStyleSheet();
			advancedCSS.styleSheet = _css;
			
			var tf:TextField = new TextField();
			advancedCSS.format( tf, "default" );
			tf.htmlText = "<span class='default'>HELLO WORLD</span><span class='arno_connard'>TOTOTOT</span>";
			addChild( tf );
		}
		
		private function initTextManager():void
		{			
			var tf:TextField = new TextField();
			textManager.setText( tf, "HELLO WORLD", "default2", 0, 0 );
			addChild( tf );
		}
		
		private function initText():void
		{
			var tf:Text = new Text( "HELLO WORLD", "default3" );
			addChild( tf );			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}