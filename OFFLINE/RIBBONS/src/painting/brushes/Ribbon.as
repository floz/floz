
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.GraphicsPathCommand;
	import flash.utils.getTimer;
	
	public class Ribbon extends Sprite implements IBrush
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private static var FRICTION:Number = .8;
		private static var SLOWDOWN:Number = .05;
		private static var RIBBON_SIZE:Number = 90;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _color:uint;
		private var _adaptSize:Boolean;
		private var _diffX:Number;
		private var _diffY:Number;
		private var _g:Graphics;
		
		private var _dx:Number;
		private var _dy:Number;
		private var _px:Number;
		private var _py:Number;
		private var _vx:Number;
		private var _vy:Number;
		
		private const _commands:Vector.<int> = Vector.<int>( [ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO ] );
		private const _datas:Vector.<Number> = new Vector.<Number>( 10, true );
		
		private var _lastx1:Number;
		private var _lasty1:Number;
		private var _lastx2:Number;
		private var _lasty2:Number;
		
		private var _inited:Boolean;
		private var _linked:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Ribbon( color:uint, adaptSize:Boolean = false, diffX:Number = 0, diffY:Number = 0 ) 
		{
			this._color = color;
			this._adaptSize = adaptSize;
			this._diffX = diffX;
			this._diffY = diffY;
			
			init();
			reset();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_g = this.graphics;
			
			this.mouseEnabled =
			this.mouseChildren = false;
		}
		
		private function drawSegment( x1:Number, y1:Number, x2:Number, y2:Number, a:Number ):void
		{
			var tx:Number = x2 - x1;
			var ty:Number = y2 - y1;
			
			var rayon:Number = Math.sqrt( tx * tx + ty * ty ) * .5;
			
			var s:Number = _adaptSize ? ( a > 0 ? a : -a ) * .5 : RIBBON_SIZE;
			
			var posX:Number = Math.cos( s ) * rayon * .5;
			var posY:Number = Math.sin( s ) * rayon * .5;
			
			var ox:Number = x1 + tx * .5;
			var oy:Number = y1 + ty * .5;
			
			var rot:Number = Math.atan2( posY, posX );
			
			_g.clear();
			_g.lineStyle( 1, _color );
			
			if ( _linked )
			{
				_datas[ 0x0 ] = 
				_datas[ 0x8 ] = _lastx2;
				
				_datas[ 0x1 ] = 
				_datas[ 0x9 ] = _lasty2;
				
				_datas[ 0x2 ] = _lastx1;
				_datas[ 0x3 ] = _lasty1;
			}
			else
			{
				_datas[ 0x0 ] =
				_datas[ 0x8 ] = rayon * Math.cos( -rot + a ) + ox;
				
				_datas[ 0x1 ] =
				_datas[ 0x9 ] = rayon * Math.sin( -rot + a ) + oy;
				
				_datas[ 0x2 ] = rayon * Math.cos( rot + a ) + ox;
				_datas[ 0x3 ] = rayon * Math.sin( rot + a ) + oy;
				
				_linked = true;
			}
			
			_lastx1 =
			_datas[ 0x4 ] = rayon * Math.cos( rot + a ) + ox;
			_lasty1 =
			_datas[ 0x5 ] = rayon * Math.sin( rot + a ) + oy;
			
			_lastx2 =
			_datas[ 0x6 ] = rayon * Math.cos( -rot + a ) + ox;
			_lasty2 =
			_datas[ 0x7 ] = rayon * Math.sin( -rot + a ) + oy;
			
			_g.drawPath( _commands, _datas );
		}
		
		private function toRadians( value:Number ):Number
		{
			return ( value * Math.PI / 180 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( mx:Number, my:Number ):void
		{
			if ( !_inited )
			{
				this._px = mx;
				this._py = my;
				
				_inited = true;
			}
			
			_dx = _px;
			_dy = _py;
			
			_px -= _vx = ( _vx + ( _px - mx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			_py -= _vy = ( _vy + ( _py - my ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			drawSegment( _dx, _dy, _px, _py, Math.atan2( _py - _dy, _px - _dx ) );
		}
		
		public function reset():void
		{
			_vx = 
			_vy = 0;
			
			_inited = false;
			_linked = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}