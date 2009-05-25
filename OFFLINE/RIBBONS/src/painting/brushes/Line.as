
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	
	public class Line extends Sprite implements IBrush
	{
		
		// - STATIC ----------------------------------------------------------------------
		
		private static var FRICTION:Number = .8;
		private static var SLOWDOWN:Number = .05; 
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _color:uint;
		private var _diffX:Number;
		private var _diffY:Number;
		private var _g:Graphics;
		
		private const _commands:Vector.<int> = Vector.<int>( [ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO ] );
		private const _datas:Vector.<Number> = new Vector.<Number>( 4, true );
		
		private var _px:Number;
		private var _py:Number;
		private var _vx:Number;
		private var _vy:Number;
		private var _tx:Number;
		private var _ty:Number;
		
		private var _inited:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Line( color:uint = 0x000000, diffX:Number = 0, diffY:Number = 0 ) 
		{
			this._color = color;
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
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( mx:Number, my:Number ):void
		{
			if ( !_inited )
			{
				this._px = mx;
				this._py = my;
				
				_inited = true;
			}
			
			_g.clear();
			_g.lineStyle( 1, _color );
			
			_datas[ 0 ] = _px;
			_datas[ 1 ] = _py;
			
			_px -= _vx = ( _vx + ( _px - mx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			_py -= _vy = ( _vy + ( _py - my ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			_datas[ 2 ] = _px;
			_datas[ 3 ] = _py;
			
			_g.drawPath( _commands, _datas );
		}
		
		public function reset():void
		{
			_vx =
			_vy = 0;
			
			_inited = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}