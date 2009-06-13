
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.ribbons.type 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import painting.interfaces.IBrushDatas;
	
	public class RibbonDatas extends Sprite implements IBrushDatas
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _colors:Vector.<uint>;
		private var _alphas:Vector.<Number>;
		private var _canvasWidth:Number;
		private var _canvasHeight:Number;
		
		private var _colorsCount:int;
		private var _alphasCount:int;
		private var _colorsIdx:int;
		private var _alphasIdx:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var px:Number;
		public var py:Number;
		public var vx:Number;
		public var vy:Number;
		public var dx:Number;
		public var dy:Number;
		
		public var x1:Number;
		public var y1:Number;
		public var x2:Number;
		public var y2:Number;
		
		public var brush:Shape;
		public var canvas:BitmapData;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function RibbonDatas( colors:Vector.<uint>, alphas:Vector.<Number>, canvasWidth:Number, canvasHeight:Number ) 
		{
			this.colors = colors;
			this.alphas = alphas;
			this._canvasWidth = canvasWidth;
			this._canvasHeight = canvasHeight;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			x1 =
			y1 =
			x2 =
			y2 =
			dx =
			dy =
			px =
			py = NaN;
			
			vx = 
			vy = 0;
			
			colors = colors;
			alphas = alphas;
			
			brush = new Shape();
			
			canvas = new BitmapData( _canvasWidth, _canvasHeight, true, 0x00 );
			addChild( new Bitmap( canvas, PixelSnapping.NEVER, false ) );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void
		{
			brush.graphics.clear();
			brush = null;
			
			canvas.dispose();
			canvas = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get alphas():Vector.<Number> { return _alphas; }
		
		public function set alphas(value:Vector.<Number>):void 
		{
			_alphas = value;
			_alphasCount = _alphas.length;
			_alphasIdx = 0;
		}
		
		public function get colors():Vector.<uint> { return _colors; }
		
		public function set colors(value:Vector.<uint>):void 
		{
			_colors = value;
			_colorsCount = _colors.length;
			_colorsIdx = 0;
		}
		
		public function get colorsIdx():int { return _colorsIdx; }
		
		public function set colorsIdx(value:int):void 
		{
			if ( value < 0 ) _colorsIdx = int( _colorsCount - 1 );
			else if ( value > int( _colorsCount - 1 ) ) _colorsIdx = 0;
			else _colorsIdx = value;
		}
		
		public function get alphasIdx():int { return _alphasIdx; }
		
		public function set alphasIdx(value:int):void 
		{
			if ( value < 0 ) _alphasIdx = int( _alphasCount - 1 );
			else if ( value > int( _alphasCount - 1 ) ) _alphasIdx = 0;
			else _alphasIdx = value;			
		}
		
	}
	
}