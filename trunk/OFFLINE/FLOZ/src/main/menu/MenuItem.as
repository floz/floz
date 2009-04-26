
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main.menu 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gs.easing.Quad;
	import gs.TweenLite;
	import main.Config;
	
	public class MenuItem extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sectionId:int;
		private var _sectionName:String;
		
		private var _black:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var z:SimpleButton;
		public var cnt:Sprite;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MenuItem( sectionId:int, sectionName:String ) 
		{
			this._sectionId = sectionId;
			this._sectionName = 
			this.name = sectionName;
			
			init();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			var tf:TextFormat = new TextFormat( Config.fonts.getItemLoaded().futuraLight.fontName, 36, 0xb4c59c );
			var t:TextField = new TextField();
			t.text = Config.RUBRIQUES[ _sectionId ].toUpperCase();
			t.setTextFormat( tf );
			t.width = t.textWidth + 10;
			t.x = 15;
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( 0x000000, .4 );
			g.drawRect( 0, 0, t.textWidth + 30, 50 );
			g.endFill();
			
			z.width = s.width;
			z.height = 50;
			
			cnt.addChild( t );
			
			_black = new Shape();
			g = _black.graphics;
			g.beginFill( 0x000000 );
			g.drawRect( 0, 0, s.width, s.height );
			g.endFill();
			_black.scaleY = 0;
			
			var bd:BitmapData = new BitmapData( s.width, s.height, true, 0x00 );
			bd.draw( cnt );
			
			while ( cnt.numChildren ) cnt.removeChildAt( 0 );
			cnt.addChild( s );
			cnt.addChild( _black );
			cnt.addChild( new Bitmap( bd, PixelSnapping.AUTO, true ) );			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function over():void
		{
			if ( Config.currentSection == _sectionName ) return;
			TweenLite.to( _black, .3, { scaleY: 1, ease: Quad.easeOut } );			
		}
		
		public function out():void
		{
			if ( Config.currentSection == _sectionName ) return;
			TweenLite.to( _black, .3, { scaleY: 0, ease: Quad.easeOut } );		
		}
		
		public function select():void
		{
			TweenLite.to( _black, .3, { scaleY: 1, ease: Quad.easeOut } );
		}
		
		public function deselect():void
		{
			TweenLite.to( _black, .3, { scaleY: 0, ease: Quad.easeOut } );	
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function getSectionName():String
		{
			return _sectionName;
		}
		
	}
	
}