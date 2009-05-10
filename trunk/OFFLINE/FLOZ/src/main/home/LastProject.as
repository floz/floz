
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.home 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import fr.minuit4.net.loaders.types.MovieLoader;
	import fr.minuit4.utils.UImg;
	import gs.easing.Quad;
	import gs.TweenLite;
	import main.Borders;
	import main.Config;
	
	public class LastProject extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		public static const OVER:String = "lastproject_over";
		public static const OUT:String = "lastproject_out";
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _movieLoader:MovieLoader;
		private var _overEvent:Event;
		private var _outEvent:Event;
		
		private var _borders:Borders;
		
		private var _loading:Boolean;
		private var _imageHolder:Bitmap;
		
		private var _enable:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var z:SimpleButton;
		public var cntContent:Sprite;
		public var cntTitle:Sprite;
		public var strkContent:Sprite;
		public var strkTitle:Sprite;
		public var shadow:Sprite;
		public var cntBorders:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LastProject() 
		{
			_movieLoader = new MovieLoader();
			_movieLoader.addEventListener( Event.COMPLETE, onLoadComplete );
			
			_overEvent = new Event( LastProject.OVER );
			_outEvent = new Event( LastProject.OUT );
			
			shadow.alpha = 0;			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			z.removeEventListener( MouseEvent.MOUSE_OVER, onOver );
			z.removeEventListener( MouseEvent.MOUSE_OUT, onOut );
			
			_imageHolder.bitmapData.dispose();
			_imageHolder.bitmapData = null;
			
			TweenLite.killTweensOf( shadow );
			TweenLite.killTweensOf( cntTitle );
			TweenLite.killTweensOf( strkTitle );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_borders = new Borders( 320, 359, 15, 15 );
			cntBorders.addChild( _borders );
			
			cntTitle.mouseEnabled =
			cntTitle.mouseChildren = false;
			strkTitle.buttonMode = true;
			
			cntTitle.y = 
			strkTitle.y = int( 359 - 40 );
			
			z.addEventListener( MouseEvent.MOUSE_OVER, onOver );
			z.addEventListener( MouseEvent.MOUSE_OUT, onOut );
			z.addEventListener( MouseEvent.CLICK, onClick );
			strkTitle.addEventListener( MouseEvent.CLICK, onClick );
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
			trace( "click" );
		}
		
		private function onLoadComplete(e:Event):void 
		{
			_loading = false;
			
			var bd:BitmapData = UImg.resize( Bitmap( _movieLoader.getItemLoaded() ).bitmapData.clone(), strkContent.width, strkContent.height, false );
			_imageHolder = new Bitmap( bd, PixelSnapping.AUTO, true );
			cntContent.addChild( _imageHolder );
			
			_movieLoader.destroy();
			_movieLoader = null;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function destroy():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function linkToProject( name:String, img:String, section:String ):void
		{
			_loading = true;
			
			var textField:TextField = new TextField();
			textField.styleSheet = Config.styleSheet;
			textField.htmlText = "<span class='lastprojects_preview_title'>" + section.toUpperCase() + " / " + name.toUpperCase() + "</span>";
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.x =
			textField.y = 9;
			textField.selectable = false;
			cntTitle.addChild( textField );
			
			var glowFilter:GlowFilter = Config.glowFilter.clone() as GlowFilter;
			glowFilter.strength = 3;
			strkTitle.filters = 
			textField.filters =	[ glowFilter ];
			strkContent.filters = [ Config.glowFilter ];			
			
			var url:String = Config.path_img;
			url += section == Config.WORKS ? Config.path_works : Config.path_lab;
			url += "preview/" + img;
			_movieLoader.load( url );
		}
		
		public function init():void
		{
			showBorders();
			
			TweenLite.to( cntTitle, .3, { y: 359, ease: Quad.easeOut } );
			TweenLite.to( strkTitle, .3, { y: 359, ease: Quad.easeOut } );
			
			_enable = true;
		}
		
		public function kill( delay:int ):void
		{
			_enable = false;
			
			var d:Number = delay * .1;
			
			_borders.hide( d );
			TweenLite.to( cntTitle, .3, { y: int( 359 - 40 ), delay: d, ease: Quad.easeOut, onUpdate: function():void { trace( "here" ); } } );
			TweenLite.to( strkTitle, .3, { y: int( 359 - 40 ), ease: Quad.easeOut, delay: d, onComplete: destroy } );
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
		}
		
		public function hideBorders():void
		{
			_borders.hide();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}