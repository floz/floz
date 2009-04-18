
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
		private var _diaporama:SlidingDiaporama;		
		private var _loader:MassLoader;
		
		private var _currentRubIdx:int;
		private var _loadIdx:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:MovieClip;
		public var zNext:MovieClip;
		public var zPrev:MovieClip;
		
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
			
			var day:Day;
			var n:int = _datas.length;
			for ( var i:int; i < n; ++i )
			{
				day = new Day();
				day.txt.text = _datas[ i ].name;
				day.y = i * day.height + 10 * i;
				cnt.addChild( day );
				
				day.addEventListener( MouseEvent.CLICK, onDayClick );
			}
			
			_diaporama = new SlidingDiaporama( 650, 488, 0x000000 );
			_diaporama.x = 980 * .5 - 650 * .5;
			addChild( _diaporama );
			
			
			zNext.addEventListener( MouseEvent.CLICK, onClick );
			zPrev.addEventListener( MouseEvent.CLICK, onClick );
			
			_loader = new MassLoader();
			_loader.addEventListener( Event.COMPLETE, onImageComplete );
			_loader.addItems( _datas[ 0 ].photos );
			_loader.loadNext();
			
			addChild( new FPS() );
		}
		
		private function onDayClick(e:MouseEvent):void 
		{
			_currentRubIdx = cnt.getChildIndex( e.currentTarget as Day );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case zNext: _diaporama.next(); break;
				case zPrev: _diaporama.previous(); break;
			}
		}
		
		private function onImageComplete(e:Event):void 
		{
			_diaporama.addImage( MassLoader( e.currentTarget ).getItemLoaded() );
			
			_loader.loadNext();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getXMLDatas():Array
		{
			var x:XML;
			
			var datas:Array = [];
			var a:Array;
			var i:int;
			var n:int;
			for each( x in _xml.jour )
			{
				a = [];
				n = x.photo.length();
				for ( i = 0; i < n; ++i )
					a.push( x.photo.@name[ i ] );
				
				datas.push( { name: x.@name, photos: a } );
			}
			
			return datas;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}