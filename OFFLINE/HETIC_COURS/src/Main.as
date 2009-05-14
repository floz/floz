
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.net.loaders.types.MassLoader;
	import fr.minuit4.net.loaders.types.TextLoader;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _textLoader:TextLoader;
		private var _datasPetites:/*String*/Array;
		private var _datasGrandes:/*String*/Array;
		private var _massLoader:MassLoader;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_textLoader = new TextLoader();
			_textLoader.addEventListener( Event.COMPLETE, onXMLComplete );
			_textLoader.load( "galerie.xml" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onXMLComplete(e:Event):void 
		{
			var xml:XML = XML( _textLoader.getItemLoaded() );
			_textLoader.removeEventListener(Event.COMPLETE, onXMLComplete);
			_textLoader.destroy();
			_textLoader = null;
			
			_datasPetites = [];
			_datasGrandes = [];
			
			var x:XML;
			for each( x in xml.photo )
			{
				_datasPetites.push( "vignettes/" + x.@petite )
				_datasGrandes.push( "vignettes/" + x.@grande );
			}
			
			_massLoader = new MassLoader();
			_massLoader.addEventListener( Event.COMPLETE, onLoadComplete );
			_massLoader.addItems( _datasPetites );
			_massLoader.loadNext();
		}
		
		private function onLoadComplete(e:Event):void 
		{
			var b:Bitmap = new Bitmap( Bitmap( _massLoader.getItemLoaded() ).bitmapData.clone(), PixelSnapping.AUTO, true );
			b.x = ( stage.stageWidth / _massLoader.itemsCount ) * numChildren;
			addChild( b );
			
			_massLoader.loadNext();
			
			if ( !_massLoader.hasNext() )
			{
				_massLoader.destroy();
				_massLoader.removeEventListener( Event.COMPLETE, onLoadComplete );
			}
		}
		
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}