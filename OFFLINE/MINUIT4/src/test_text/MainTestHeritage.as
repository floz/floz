
/**
 * @author Floz
 */
package test_text 
{
	import assets.fonts.AssetHelveticaBlack;
	import flash.display.Sprite;
	import flash.events.Event;
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
			_dataLoader.load( "assets/css/heritage_advancedStyle.css" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function dataCompleteHandler(e:Event):void 
		{
			textManager.parseCSS( _dataLoader.content );
			
			var text:Text = new Text( "Hello world", "test2" );
			addChild( text );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}

}