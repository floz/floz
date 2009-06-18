
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.net.loaders.types.MovieLoader;
	import fr.minuit4.net.loaders.types.TextLoader;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _imgLoader:MovieLoader;
		private var _xmlLoader:TextLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_imgLoader = new MovieLoader();
			//_imgLoader.addEventListener( Event.COMPLETE, onLoadComplete );
			//_imgLoader.load( "assets/icone_news.png" );
			
			_xmlLoader = new TextLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, onXMLComplete );
			_xmlLoader.load( "assets/icone_parsed.xml" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLoadComplete(e:Event):void 
		{
			_imgLoader.removeEventListener( Event.COMPLETE, onLoadComplete );
			var png:BitmapData = Bitmap( _imgLoader.getItemLoaded() ).bitmapData.clone();
			_imgLoader.destroy();
			_imgLoader = null;
			
			trace( Parsing.readImgParsed( Parsing.parsePng( png ) ) );
		}
		
		private function onXMLComplete(e:Event):void 
		{
			_xmlLoader.removeEventListener( Event.COMPLETE, onXMLComplete );
			var xml:XML = XML( _xmlLoader.getItemLoaded() );
			_xmlLoader.destroy();
			_xmlLoader = null;
			
			var a:Array = xml.icone as Array;
			trace( a[ 0 ] );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}