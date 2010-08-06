
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
	import fr.minuit4.net.loaders.DataLoader;
	import fr.minuit4.text.managers.fontManager;
	import fr.minuit4.text.managers.textManager;
	import fr.minuit4.text.Text;

	public class MainTestHeritage extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _dataLoader:DataLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainTestHeritage() 
		{
			fontManager.registerFont( AssetHelveticaBlack );
			fontManager.traceFonts();
			
			_dataLoader = new DataLoader();
			_dataLoader.addEventListener( Event.COMPLETE, dataCompleteHandler, false, 0, true );
			
			// Héritage simple : ".parent>.enfant"
			// Pas d'héritage à foisson genre : ".parent>.enfant>.enfant2"
			// Par contre on peut faire :
			// .parent { ... }
			// .parent>.enfant { ... }
			// .enfant>.enfant2 { ... }
			_dataLoader.load( "assets/css/heritage_advancedStyle.css" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function dataCompleteHandler(e:Event):void 
		{
			var css:StyleSheet = new StyleSheet();
			css.parseCSS( _dataLoader.content );
			
			var tf:TextField = new TextField();
			tf.embedFonts = true;
			tf.styleSheet = css;
			tf.htmlText = "<span class='parent>.enfant'>HELLO WORLD</span>"; // Bouh ! Le naze, il n'a pas les propriétés de "parent"
			addChild( tf );
			
			textManager.parseCSS( _dataLoader.content );
			
			var text:Text = new Text( "Hello world", "enfant" ); // Ah ! Le roksor ! Il a les propriétés de "parent" ET de "enfant"
			addChild( text );
			
			var t2:Text = new Text( "Hello world", "enfant2" ); // Et lui c'est un ouf, il a "parent", "enfant" et "enfant2" :)
			addChild( t2 );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}