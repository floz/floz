
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class LoaderBar extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _totalWidth:Number;
		private var _totalHeight:Number;
		private var _color:uint;
		private var _backgroundColor:uint;
		private var _totalLoads:int;
		private var _textHolder:BitmapData;
		
		private var _idxLoad:int;
		private var _field:TextField;
		
		private var _fillBar:Shape;
		private var _backgroundBar:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function LoaderBar( totalWidth:Number, totalHeight:Number, color:uint, backgroundColor:uint, totalLoads:int = 0 ) 
		{
			this._totalWidth = totalWidth;
			this._totalHeight = totalHeight;
			this._color = color;
			this._backgroundColor = backgroundColor;
			this._totalLoads = totalLoads;
			
			_backgroundBar = getBar( true );
			addChild( _backgroundBar );
			
			_fillBar = getBar( false );
			addChild( _fillBar );
			
			var format:TextFormat = new TextFormat( "_sans", 9 );
			_field = new TextField();
			_field.defaultTextFormat = format;
			_field.textColor = color;
			_field.text = "LOADING : " + _idxLoad.toString() + "/" + _totalLoads.toString();
			_field.cacheAsBitmap = true;			
			
			_textHolder = new BitmapData( _totalWidth, _totalHeight + 10, true, 0x00 );
			var b:Bitmap = new Bitmap( _textHolder, PixelSnapping.AUTO, true );
			b.y = _totalHeight;
			addChild( b );
			
			_textHolder.fillRect( _textHolder.rect, 0x00 );
			_textHolder.draw( _field );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_fillBar.scaleX = 0;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function getBar( background:Boolean ):Shape
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.beginFill( background ? _backgroundColor : _color );
			g.drawRect( 0, 0, _totalWidth, _totalHeight );
			g.endFill();
			
			return s;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function toPercent( percent:Number ):void
		{
			_fillBar.scaleX = percent;
		}
		
		public function next():void
		{
			++_idxLoad;
			_fillBar.scaleX = 0;
			
			_field.text = "LOADING : " + _idxLoad.toString() + "/" + _totalLoads.toString();
			_textHolder.fillRect( _textHolder.rect, 0x00 );
			_textHolder.draw( _field );
		}
		
		public function reset():void
		{
			_idxLoad = 0;
			_fillBar.scaleX = 0;
			
			_field.text = "LOADING : " + _idxLoad.toString() + "/" + _totalLoads.toString();
			_textHolder.fillRect( _textHolder.rect, 0x00 );
			_textHolder.draw( _field );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function set totalLoads( value:int ):void { this._totalLoads = value; }
		public override function get width():Number { return _totalWidth; }
		public override function get height():Number { return _totalHeight; }
		
	}
	
}