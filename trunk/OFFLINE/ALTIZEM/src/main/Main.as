
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
	import flash.display.PixelSnapping;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	import fr.minuit4.tools.loaders.types.ImageLoader;
	import fr.minuit4.tools.loaders.types.TextLoader;
	import fr.minuit4.tools.Loading;
	import fr.minuit4.tools.perfs.FPS;
	import fr.minuit4.utils.UBit;
	import gs.easing.Linear;
	import gs.easing.Quad;
	import gs.TweenLite;
	
	public class Main extends MovieClip
	{
		// - CONST -----------------------------------------------------------------------
		
		private const WIDTH:Number = 880;
		private const HEIGHT:Number = 205;
		private const BLURFILTER:BlurFilter = new BlurFilter( 40, 40, 3 );
		private const POINT:Point = new Point();
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _loading:Loading;
		private var _image:BitmapData;
		private var _blurImage:BitmapData;
		private var _blurHolder:Bitmap;
		private var _appearText:TextField;
		private var _textHolder:TextHolder;
		
		private var _xml:XML;
		private var _itemsInfos:Array;
		private var _itemsCount:int;
		private var _imagesLoaded:Array;
		private var _timer:Timer;
		private var _imageLoader:ImageLoader;
		
		private var _currentIndex:int;
		private var _scroll:Number = 0;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var cnt:MovieClip;
		public var z:SimpleButton;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_loading = new Loading( 0x888888 );
			_loading.x = stage.stageWidth * .5 - _loading.width * .5;
			_loading.y = stage.stageHeight * .5 - _loading.height * .5;
			_loading.play();
			addChild( _loading );
			
			_image = new BitmapData( WIDTH, HEIGHT, false, 0xffffff );
			cnt.addChild( new Bitmap( _image, PixelSnapping.AUTO, true ) );			
			
			_textHolder = new TextHolder();
			_appearText = _textHolder.txt;
			_appearText.text = "";
			
			_blurImage = new BitmapData( WIDTH, height, false, 0xffffff );
			_blurHolder = new Bitmap( _blurImage, PixelSnapping.AUTO, true );
			cnt.addChild( _blurHolder );
			
			var xmlLoader:TextLoader = new TextLoader();
			xmlLoader.addEventListener( Event.COMPLETE, onComplete );
			xmlLoader.load( path_xml + "datas.xml" );
			
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onComplete(e:Event):void 
		{
			_xml = XML( TextLoader( e.currentTarget ).getItemLoaded() );
			TextLoader( e.currentTarget ).destroy();
			
			_itemsInfos = getXMLInfos();
			_itemsCount = _itemsInfos.length;
			
			_imagesLoaded = [];
			
			_timer = new Timer( 0 );
			_timer.addEventListener( TimerEvent.TIMER, onTimer );
			
			_imageLoader = new ImageLoader();
			_imageLoader.addEventListener( Event.COMPLETE, onImageComplete );
			_imageLoader.load( path_img + _itemsInfos[ _currentIndex ].img );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			navigateToURL( new URLRequest( "http://www.altizem.fr" ) );
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			if ( !_imagesLoaded[ _currentIndex ] ) return;
			
			switchImage();
			if ( _currentIndex >= _itemsCount ) _currentIndex = 0;
		}
		
		private function onImageComplete(e:Event):void 
		{
			_imagesLoaded.push( Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone() );
			
			if ( !_timer.running )
			{
				switchImage();
				_timer.start();
				_loading.stop();
			}
			
			if ( _imagesLoaded.length >= int( _itemsCount ) )
			{
				_imageLoader.destroy();
				return;
			}
			_imageLoader.load( path_img + _itemsInfos[ _imagesLoaded.length ].img );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getXMLInfos():Array
		{
			var x:XML;
			
			var a:Array = [];
			for each( x in _xml[ language ].item ) a.push( { wait: x.@wait, img: x.@img, txt: x.@txt, txtX: x.@txtX, txtY: x.@txtY } );
			
			return a;
		}
		
		private function switchImage():void
		{
			_image.fillRect( _image.rect, 0x00 );
			_image.draw( UBit.resize( _imagesLoaded[ _currentIndex ], WIDTH, HEIGHT, false ) );
			
			_appearText.x = _itemsInfos[ _currentIndex ].txtX;
			_appearText.y = _itemsInfos[ _currentIndex ].txtY;
			_appearText.text = _itemsInfos[ _currentIndex ].txt;
			_image.draw( _textHolder );
			
			_blurImage.draw( _image );
			_blurImage.applyFilter( _blurImage, _blurImage.rect, POINT, BLURFILTER );
			_blurHolder.alpha = 1;
			TweenLite.to( _blurHolder, 1, { alpha: 0, ease: Quad.easeOut } );
			
			_timer.delay = _itemsInfos[ _currentIndex ].wait * 1000;
			
			_currentIndex++;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_img():String { return loaderInfo.parameters[ "path_img" ] || "assets/img/"; }
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }		
		public function get language():String { return loaderInfo.parameters[ "language" ] || "fr"; }
	}
	
}