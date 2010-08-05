
/**
 * @author Floz
 */
package test_text 
{
	import assets.fonts.AssetHelveticaBlack;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import fr.minuit4.net.loaders.DataLoader;
	import fr.minuit4.text.managers.fontManager;
	import fr.minuit4.text.managers.textManager;
	import fr.minuit4.text.styles.Style;
	import fr.minuit4.text.Text;

	public class MainTestText extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dataLoader:DataLoader;
		private var _text:Text;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestText() 
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
			textManager.parseCSS( _dataLoader.content );
			
			_text = new Text( "HELLO WORLD SALUT HAHAHA HAHAHAHAHA HAHA HAH HAHAH HA A", "testInput" );
			addChild( _text );
			
			var tf:TextField = new TextField();
			textManager.setText( tf, "HELLO WORLD SALUT HAHAHA HAHAHAHAHA HAHA HAH HAHAH HA A", "testInput2", 0, 0 );
			tf.x = 200;
			addChild( tf );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}