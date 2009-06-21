
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.Sprite;
	import painting.interfaces.IBrush;
	
	public class AbstractBrush extends Sprite implements IBrush
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _colors:Vector.<uint>;
		protected var _alphas:Vector.<Number>;
		protected var _diffX:Number;
		protected var _diffY:Number;
		
		protected var _core:BrushDatas;
		
		protected var _released:Boolean;
		protected var _enabled:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractBrush( colors:Vector.<uint>, alphas:Vector.<Number>, diffX:Number = 0, diffY:Number = 0 ) 
		{
			this._colors = colors;
			this._alphas = alphas;
			this._diffX = diffX;
			this._diffY = diffY;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			this.mouseEnabled =
			this.mouseChildren = false;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function create():void
		{
			_core = new BrushDatas( _colors, _alphas, stage.stageWidth, stage.stageHeight );
			addChild( _core );
			
			_core.colors = _colors;
			_core.alphas = _alphas;
			
			_enabled = true;
		}
		
		public function paint(mx:Number, my:Number):void
		{
			throw new Error( "Abstract method of an abstract class. It must be overrided" );
		}
		
		public function completePainting():int
		{
			throw new Error( "Abstract method of an abstract class. It must be overrided" );
		}
		
		public function release(mx:Number, my:Number):void
		{
			if ( _released ) return;
			
			_released = true;
			
			_core.dx = mx;
			_core.dy = my;
		}
		
		public function dispose():void
		{
			_core.dispose();
		}
		
		public function copy():IBrush
		{
			throw new Error( "Abstract method of an abstract class. It must be overrided" );
		}
		
		public function setColors( colors:Vector.<uint> ):void
		{ 
			_colors = colors;
			if ( !_core ) return;
			_core.colors = colors;
		}
		
		public function setAlphas( alphas:Vector.<Number> ):void
		{
			_alphas = alphas;
			if ( !_core ) return;
			_core.alphas = alphas;
		}
		
		public function setDiffX( value:Number ):void { this._diffX = value; }
		
		public function setDiffY( value:Number ):void { this._diffY = value; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get released():Boolean { return this._released; }
		
		public function set enabled( value:Boolean ):void { this._enabled = value; }
		
	}
	
}