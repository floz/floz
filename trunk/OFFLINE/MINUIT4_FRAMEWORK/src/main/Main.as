
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import fr.minuit4.tools.loaders.types.TextLoader;
	
	public class Main extends MovieClip
	{
		private var loader:ImageLoader;
		private var _xmlLoader:TextLoader;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			loader = new ImageLoader();
			loader.addEventListener( Event.COMPLETE, onComplete );
			loader.load( "grosllamahwin4.jpg" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
				private function onComplete(e:Event):void 
		{
			var b:BitmapData = Bitmap( loader.getItemLoaded() ).bitmapData.clone();
			addChild( new Bitmap( b ) );
			loader.destroy();
			
			_xmlLoader = new TextLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, onXMLComplete );
			_xmlLoader.load( "datas.xml" );
		}
		
		private function onXMLComplete(e:Event):void 
		{
			var x:XML = XML( _xmlLoader.getItemLoaded() );
			_xmlLoader.destroy();
			trace( x );		
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}