
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import assets.Fonts;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import fr.minuit4.tools.loaders.types.MovieLoader;
	import fr.minuit4.tools.loaders.types.TextLoader;
	
	public class Preloader extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _imageLoader:MovieLoader;
		private var _fonts:Fonts;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Preloader() 
		{
			// Hello world
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onXMLComplete(e:Event):void 
		{
			var xml:XML = XML( ( e.currentTarget as TextLoader ).getItemLoaded() );
			parseXML( xml );
			
			( e.currentTarget as TextLoader ).removeEventListener( Event.COMPLETE, onXMLComplete );
			( e.currentTarget as TextLoader ).destroy();
			
			_imageLoader = new MovieLoader();
			_imageLoader.addEventListener( Event.COMPLETE, onBackgroundComplete );
			_imageLoader.load( Config.path_img + "background.jpg" );
		}
		
		private function onBackgroundComplete(e:Event):void 
		{
			Config.background = Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone();
			_imageLoader.removeEventListener( Event.COMPLETE, onBackgroundComplete );
			_imageLoader.destroy();
			_imageLoader = null;
			
			_fonts = new Fonts();
			_fonts.addEventListener( Event.COMPLETE, onFontsComplete );
			_fonts.load( Config.path_swf + "fonts.swf" );
		}
		
		private function onFontsComplete(e:Event):void 
		{
			Config.fonts = _fonts;			
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function parseXML( xml:XML ):void
		{
			var x:XML;
			var a:Array = [];
			var o:Object = { };
			var list:Array = [ Config.WORKS, Config.LAB ];
			const n:int = list.length;
			
			for ( var i:int; i < n; ++i )
			{
				for each( x in xml[ list[ i ] ].item )
				{
					o.section = list[ i ];
					o.title = x.@title;
					o.preview = x.@preview;
					o.pubdate = x.@pubdate;
					o.client = x.client;
					o.job = x.job;
					o.technos = x.technos;
					o.url = x.url;
					o.desc = x.desc;
					for each( x in x.diaporama.image )
						a.push( x.name );
					
					o.diaporama = a;
					
					Config[ list[ i ] + "Datas" ].push( o );
					
					a = [];
					o = { };
				}
				Config[ list[ i ] + "Datas" ].sortOn( "pubdate", Array.DESCENDING | Array.NUMERIC )
			}
			
			Config.path_img = xml.path.@img;
			Config.path_works = xml.path.@works;
			Config.path_lab = xml.path.@lab;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function init():void
		{
			var _xmlLoader:TextLoader = new TextLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, onXMLComplete );
			_xmlLoader.load( Config.path_xml + "datas.xml" );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}