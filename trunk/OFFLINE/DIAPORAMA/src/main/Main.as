
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import fr.minuit4.diaporama.types.FadingDiaporama;
	import fr.minuit4.diaporama.types.SlidingDiaporama;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import fr.minuit4.tools.loaders.types.MassLoader;
	import fr.minuit4.tools.loaders.types.TextLoader;
	import fr.minuit4.tools.perfs.FPS;
	
	public class Main extends MovieClip 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _xmlLoader:TextLoader;
		
		private var _xml:XML;
		private var _datas:Array;
		private var _loader:MassLoader;
		
		private var _fadingDiaporama:FadingDiaporama;
		private var _slidingDiaporama:SlidingDiaporama;
		
		private var _currentRubIdx:int;
		private var _loadIdx:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var fading:Diaporama;
		public var sliding:Diaporama;
		public var zPrev:SimpleButton;
		public var zNext:SimpleButton;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{	
			_xmlLoader = new TextLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, onComplete );
			_xmlLoader.load( "assets/xml/datas.xml");			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onComplete(e:Event):void 
		{
			_xml = XML( _xmlLoader.getItemLoaded() );
			_xmlLoader.destroy();
			_xmlLoader = null;
			
			_datas = getXMLDatas();
			
			initDiaporama();
			
			zPrev.addEventListener( MouseEvent.CLICK, onClick );
			zNext.addEventListener( MouseEvent.CLICK, onClick );
			
			_loader = new MassLoader();
			_loader.addEventListener( Event.COMPLETE, onImageComplete );
			_loader.addItems( _datas );
			_loader.loadNext();
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zNext: 
					_fadingDiaporama.next();
					_slidingDiaporama.next();
					break;
				case zPrev: 
					_fadingDiaporama.previous(); 
					_slidingDiaporama.previous(); 
					break;
			}
		}
		
		private function onImageComplete(e:Event):void 
		{
			_fadingDiaporama.addImage( MassLoader( e.currentTarget ).getItemLoaded() );
			_slidingDiaporama.addImage( MassLoader( e.currentTarget ).getItemLoaded() );
			
			_loader.loadNext();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getXMLDatas():Array
		{
			var x:XML;
			
			var a:Array = [];
			for each( x in _xml.photo ) a.push( x.@name );
			
			return a;
		}
		
		private function initDiaporama():void
		{
			_fadingDiaporama = new FadingDiaporama( 266, 200 );
			fading.cnt.addChild( _fadingDiaporama );
			
			_slidingDiaporama = new SlidingDiaporama( 266, 200 );
			sliding.cnt.addChild( _slidingDiaporama );			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}