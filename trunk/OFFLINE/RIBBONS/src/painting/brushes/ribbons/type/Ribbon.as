
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.ribbons.type 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import painting.events.PaintingEvent;
	import painting.interfaces.IBrush;
	
	public class Ribbon extends Sprite implements IBrush
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const _commands:Vector.<int> = Vector.<int>( [ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO ] );
		private const _datas:Vector.<Number> = new Vector.<Number>( 10, true );
		
		private var _colors:Vector.<uint>;
		private var _alphas:Vector.<Number>;
		private var _diffX:Number;
		private var _diffY:Number;
		private var _adaptSize:Boolean;
		
		private var _core:RibbonDatas;
		
		private var _released:Boolean;
		private var _enable:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static var FRICTION:Number = .8;
		public static var SLOWDOWN:Number = .05;
		public static var RIBBON_SIZE:Number = 40;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Ribbon( colors:Vector.<uint>, alphas:Vector.<Number>, diffX:Number = 0, diffY:Number = 0, adaptSize:Boolean = true ) 
		{
			this._colors = colors;
			this._alphas = alphas;
			this._diffX = diffX;
			this._diffY = diffY;
			this._adaptSize = adaptSize;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function drawSequence( x1:Number, y1:Number, x2:Number, y2:Number, a:Number ):void
		{			
			var ribbon:RibbonDatas = _core;
			var g:Graphics = ribbon.brush.graphics;
			
			var tx:Number = x2 - x1;
			var ty:Number = y2 - y1;
			var rayon:Number = Math.sqrt( tx * tx + ty * ty ) * .5;
			
			var newAngle:Number = _adaptSize ? ( a > 0 ? a : -a ) * .5 : RIBBON_SIZE;
			
			var posX:Number = Math.cos( newAngle ) * rayon * .5; // * .5 ?
			var posY:Number = Math.sin( newAngle ) * rayon * .5;
			
			var ox:Number = x1 + tx * .5;
			var oy:Number = y1 + ty * .5;
			
			var rot:Number = Math.atan2( posY, posX );
			
			++ribbon.colorsIdx;
			++ribbon.alphasIdx;
			
			g.clear();
			g.lineStyle( 1, ribbon.colors[ ribbon.colorsIdx ], ribbon.alphas[ ribbon.alphasIdx ] );
			g.beginFill( ribbon.colors[ ribbon.colorsIdx ], ribbon.alphas[ ribbon.alphasIdx ] );
			
			if ( !ribbon.x1 )
			{
				ribbon.x1 = rayon * Math.cos( rot + a ) + ox;
				ribbon.y1 = rayon * Math.sin( rot + a ) + oy;
				
				ribbon.x2 = rayon * Math.cos( -rot + a ) + ox;
				ribbon.y2 = rayon * Math.sin( -rot + a ) + oy;
			}
			
			_datas[ 0x0 ] = ribbon.x2;
			_datas[ 0x1 ] = ribbon.y2;
			
			_datas[ 0x2 ] = ribbon.x1;
			_datas[ 0x3 ] = ribbon.y1;
			
			_datas[ 0x8 ] = ribbon.x2;
			_datas[ 0x9 ] = ribbon.y2;
			
			ribbon.x1 =
			_datas[ 0x4 ] = rayon * Math.cos( rot + a ) + ox;
			ribbon.y1 =
			_datas[ 0x5 ] = rayon * Math.sin( rot + a ) + oy;
			
			ribbon.x2 =
			_datas[ 0x6 ] = rayon * Math.cos( -rot + a ) + ox;
			ribbon.y2 = 
			_datas[ 0x7 ] = rayon * Math.sin( -rot + a ) + oy;
			
			g.drawPath( _commands, _datas );
			
			ribbon.canvas.draw( ribbon.brush );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function create():void
		{
			_core = new RibbonDatas( _colors, _alphas, stage.stageWidth, stage.stageHeight );
			addChild( _core );
			
			_core.colors = _colors;
			_core.alphas = _alphas;
			
			_enable = true;
		}
		
		public function paint( mx:Number, my:Number ):void
		{
			if ( !_enable ) 
				return;
			
			var ribbon:RibbonDatas = _core;
			
			if ( !ribbon.px )
			{
				ribbon.px = mx;
				ribbon.py = my;
			}
			
			var px:Number = ribbon.px;
			var py:Number = ribbon.py;
			
			ribbon.vx = ( ribbon.vx + ( ribbon.px - mx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			ribbon.vy = ( ribbon.vy + ( ribbon.py - my ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			ribbon.px -= ribbon.vx;
			ribbon.py -= ribbon.vy;
			
			drawSequence( px, py, ribbon.px, ribbon.py, Math.atan2( ribbon.py - py, ribbon.px - px ) );
		}
		
		public function completePainting():int
		{
			if ( !_enable ) 
				return 0;
			
			var ribbon:RibbonDatas = _core;
			
			var px:Number;
			var py:Number;
			var dx:Number;
			var dy:Number;
			var dist:Number;
			
			px = ribbon.px;
			py = ribbon.py;
			
			ribbon.vx = ( ribbon.vx + ( ribbon.px - ribbon.dx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			ribbon.vy = ( ribbon.vy + ( ribbon.py - ribbon.dy ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			ribbon.px -= ribbon.vx;
			ribbon.py -= ribbon.vy;
			
			dx = ( ribbon.dx - ribbon.px );
			dy = ( ribbon.dy - ribbon.dy );
			dist = Math.sqrt( dx * dx + dy * dy );
			
			if ( dist < .1 )
			{
				var paintingEvent:PaintingEvent = new PaintingEvent( PaintingEvent.BRUSH_COMPLETE );
				paintingEvent.instance = this.parent as Sprite;
				dispatchEvent( paintingEvent );
				
				ribbon.graphics.clear();
				
				return 0;
			}
			
			drawSequence( px, py, ribbon.px, ribbon.py, Math.atan2( ribbon.py - py, ribbon.px - px ) );
			
			return 1;
		}
		
		public function release( mx:Number, my:Number ):void
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
			return new Ribbon( _colors, _alphas, _diffX, _diffY, _adaptSize );
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
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get released():Boolean { return _released; }
		
		public function set enabled( value:Boolean ):void {	_enable = value; }
		
	}
	
}