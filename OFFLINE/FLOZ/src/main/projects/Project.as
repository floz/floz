﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.projects 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import fr.minuit4.animation.Loading;
	import fr.minuit4.net.loaders.types.MovieLoader;
	import fr.minuit4.utils.UImg;
	import gs.easing.Cubic;
	import gs.easing.Quad;
	import gs.TweenLite;
	import main.Borders;
	import main.Config;
	import main.ProjectEvent;
	
	public class Project extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const OVER:String = "project_over";
		public static const OUT:String = "project_out";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _movieLoader:MovieLoader;
		private var _overEvent:Event;
		private var _outEvent:Event;
		
		private var _borders:Borders;
		
		private var _loading:Loading;
		private var _imageHolder:Bitmap;
		private var _title:String;
		private var _section:String;
		private var _index:int;
		
		private var _enable:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var z:SimpleButton;
		public var cntContent:Sprite;
		public var cntTitle:Sprite;
		public var strkContent:Sprite;
		public var strkTitle:Sprite;
		public var shadow:Sprite;
		public var cntBorders:Sprite;
		public var msk:Sprite;
		public var txt:TextField;
		public var cntLoading:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Project() 
		{
			_movieLoader = new MovieLoader();
			_movieLoader.addEventListener( Event.COMPLETE, onLoadComplete );
			
			_overEvent = new Event( Project.OVER );
			_outEvent = new Event( Project.OUT );
			
			shadow.alpha = 0;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			if ( _movieLoader )
			{
				_movieLoader.removeEventListener( Event.COMPLETE, onLoadComplete );
				_movieLoader.destroy();
				_movieLoader = null;
			}
			
			if ( _imageHolder )
			{
				_imageHolder.bitmapData.dispose();
				_imageHolder = null;
			}
			
			if ( _loading && _loading.playing ) _loading.stop();
			
			z.removeEventListener( MouseEvent.MOUSE_OVER, onOver );
			z.removeEventListener( MouseEvent.MOUSE_OUT, onOut );
			
			TweenLite.killTweensOf( _loading );
			TweenLite.killTweensOf( shadow );
			TweenLite.killTweensOf( strkTitle );
			TweenLite.killTweensOf( cntTitle );
			
			_loading = null;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_loading = new Loading();
			cntLoading.addChild( _loading );
			_loading.x = strkContent.width * .5 - _loading.width * .5 + 15;
			_loading.y = strkContent.height * .5 - _loading.height * .5 + 15;
			_loading.play();
			
			_borders = new Borders( strkContent.width, strkContent.height, 10, 10 );
			cntBorders.addChild( _borders );
			
			cntTitle.mouseEnabled =
			cntTitle.mouseChildren = 
			strkTitle.buttonMode = false;
			
			cntTitle.y =
			strkTitle.y = strkContent.height;
			
			z.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			z.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			z.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if ( !_enable ) return;
			dispatchEvent( _overEvent );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			if ( !_enable ) return;
			dispatchEvent( _outEvent );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var projectEvent:ProjectEvent = new ProjectEvent( ProjectEvent.PROJECT_SELECT );
			projectEvent.index = this._index;
			projectEvent.section = this._section;
			
			dispatchEvent( projectEvent );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			_movieLoader.removeEventListener( Event.COMPLETE, onLoadComplete );
			
			TweenLite.to( _loading, .3, { alpha: 0, ease: Cubic.easeOut, onComplete: _loading.stop } );
			
			var bdTmp:BitmapData = _movieLoader.getItemLoaded().bitmapData.clone();
			var bd:BitmapData = UImg.resize( bdTmp, bdTmp.width, strkContent.height - 1, false );
			_imageHolder = new Bitmap( bd, PixelSnapping.AUTO, true );
			cntContent.addChild( _imageHolder );
			
			_movieLoader.destroy();
			_movieLoader = null;
			
			_enable = true;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( name:String, img:String, section:String, index:int ):void
		{			
			this._title = name;
			this._section = section;
			this._index = index;
			
			var textField:TextField = new TextField();
			textField.embedFonts = true;
			textField.styleSheet = Config.styleSheet;
			textField.width = strkContent.width;
			textField.htmlText = "<span class='projects_preview_title'>" + name.toUpperCase() + "</span>";
			textField.y = 14;
			textField.selectable = false;
			cntTitle.addChild( textField );
			
			var glowFilter:GlowFilter = Config.glowFilter.clone() as GlowFilter;
			textField.filters =	[ glowFilter ];
			glowFilter.strength = 3;			
			strkContent.filters = [ Config.glowFilter ];			
			
			var url:String = Config.path_img;
			url += section == Config.WORKS ? Config.path_works : Config.path_lab;
			url += "preview/" + img;
			_movieLoader.load( url );
		}
		
		public function init():void
		{
			showBorders();
			TweenLite.to( strkTitle, .2, { y: 309, ease: Quad.easeOut } );
			TweenLite.to( cntTitle, .2, { y: 309, ease: Quad.easeOut } );
		}
		
		public function kill( delay:int ):void
		{
			_enable = false;
			
			z.removeEventListener( MouseEvent.CLICK, onClick );
			
			var d:Number = delay * .05;
			TweenLite.to( strkTitle, .2, { y: strkContent.height, ease: Quad.easeOut, delay: d } );
			TweenLite.to( cntTitle, .2, { y: strkContent.height, ease: Quad.easeOut, delay: d, onComplete: destroy } );
			
			_borders.hide( d );
		}
		
		public function darken():void
		{
			TweenLite.to( shadow, .3, { alpha: .35, ease: Quad.easeOut } );			
		}
		
		public function lighten():void
		{
			TweenLite.to( shadow, .3, { alpha: 0, ease: Quad.easeOut } );
		}
		
		public function showBorders():void
		{
			_borders.show();
			TweenLite.to( strkTitle, .2, { y: 309, ease: Quad.easeOut } );
			TweenLite.to( cntTitle, .2, { y: 309, ease: Quad.easeOut } );
		}
		
		public function hideBorders():void
		{
			_borders.hide();
			TweenLite.to( strkTitle, .2, { y: cntContent.height, ease: Quad.easeOut } );
			TweenLite.to( cntTitle, .2, { y: cntContent.height, ease: Quad.easeOut } );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}