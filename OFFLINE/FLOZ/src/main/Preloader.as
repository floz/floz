﻿
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
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import fr.minuit4.net.loaders.types.MovieLoader;
	import fr.minuit4.net.loaders.types.TextLoader;
	
	public class Preloader extends EventDispatcher
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _preloaderEvent:PreloaderEvent;
		
		private var _imageLoader:MovieLoader;
		private var _textLoader:TextLoader;
		private var _fonts:Fonts;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Preloader() 
		{
			// Hello world
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLoadProgress(e:ProgressEvent):void 
		{
			_preloaderEvent = new PreloaderEvent( PreloaderEvent.PROGRESS );
			_preloaderEvent.percent = e.bytesLoaded / e.bytesTotal;
			
			dispatchEvent( _preloaderEvent );
		}
		
		private function onXMLComplete(e:Event):void 
		{
			var xml:XML = XML( ( e.currentTarget as TextLoader ).getItemLoaded() );
			parseXML( xml );
			
			dispatchChangeEvent();
			
			( e.currentTarget as TextLoader ).removeEventListener( Event.COMPLETE, onXMLComplete );
			( e.currentTarget as TextLoader ).destroy();
			
			_imageLoader = new MovieLoader();
			_imageLoader.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_imageLoader.addEventListener( Event.COMPLETE, onBackgroundComplete );
			_imageLoader.load( Config.path_img + "background.jpg" );
		}
		
		private function onBackgroundComplete(e:Event):void 
		{
			Config.background = Bitmap( _imageLoader.getItemLoaded() ).bitmapData.clone();
			_imageLoader.removeEventListener( Event.COMPLETE, onBackgroundComplete );
			_imageLoader.destroy();
			_imageLoader = null;
			
			dispatchChangeEvent();
			
			_fonts = new Fonts();
			_fonts.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_fonts.addEventListener( Event.COMPLETE, onFontsComplete );
			_fonts.load( Config.path_swf + "fonts.swf" );
		}
		
		private function onFontsComplete(e:Event):void 
		{
			_fonts.removeEventListener( Event.COMPLETE, onFontsComplete );
			_fonts.destroy();
			_fonts = null;
			
			dispatchChangeEvent();
			
			_textLoader = new TextLoader();
			_textLoader.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_textLoader.addEventListener( Event.COMPLETE, onCSSComplete );
			_textLoader.load( Config.path_css + "floz.css" );			
		}
		
		private function onCSSComplete(e:Event):void 
		{
			var s:StyleSheet = new StyleSheet();
			s.parseCSS( _textLoader.getItemLoaded() );
			Config.styleSheet = s;
			
			dispatchChangeEvent();
			
			_textLoader.removeEventListener( Event.COMPLETE, onCSSComplete );
			_textLoader.destroy();
			_textLoader = null;
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function dispatchChangeEvent():void
		{
			_preloaderEvent = new PreloaderEvent( PreloaderEvent.CHANGE );
			dispatchEvent( _preloaderEvent );
		}
		
		private function parseXML( xml:XML ):void
		{
			var x:XML;
			var a:Array = [];
			var o:Object = { };
			var list:Array = [ Config.WORKS, Config.LAB ];
			const n:int = list.length;
			
			var j:int;
			var m:int;
			
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
						a.push( x.@name );
					
					o.diaporama = a;
					
					Config[ list[ i ] + "Datas" ].push( o );
					
					a = [];
					o = { };
				}
				Config[ list[ i ] + "Datas" ].sortOn( "pubdate", Array.DESCENDING | Array.NUMERIC )
				
				a = Config[ list[ i ] + "Datas" ];
				m = a.length;
				for ( j = 0; j < m; ++j )
					a[ j ].index = j;
				
				a = [];
			}
			
			Config.aboutDatas.presentation = xml.about.presentation;
			Config.aboutDatas.skills = { flash : xml.about.skills.flash, graphic: xml.about.skills.graphic };
			Config.aboutDatas.softwares = { flash: xml.about.softwares.@flash, graphic: xml.about.softwares.@graphic };
			
			Config.path_img = xml.path.@img;
			Config.path_works = xml.path.@works;
			Config.path_lab = xml.path.@lab;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function init():void
		{
			var _xmlLoader:TextLoader = new TextLoader();
			_xmlLoader.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_xmlLoader.addEventListener( Event.COMPLETE, onXMLComplete );
			_xmlLoader.load( Config.path_xml + "datas.xml" );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}