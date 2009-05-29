
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
	
	public class DuplicateLines extends Sprite implements IBrush
	{
		
		// - STATIC ----------------------------------------------------------------------
		
		private static var FRICTION:Number = .8;
		private static var SLOWDOWN:Number = .05; 
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _color:uint;
		private var _linesCount:int;
		private var _spacing:int;
		private var _inverted:Boolean;
		private var _invertedGradient:Boolean;
		private var _maxAlpha:Number;
		private var _diffX:Number;
		private var _diffY:Number;
		private var _g:Graphics;
		
		private var _pieces:Piece;
		
		private const _commands:Vector.<int> = Vector.<int>( [ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO ] );
		private const _datas:Vector.<Number> = new Vector.<Number>( 4, true );
		
		private var _px:Number;
		private var _py:Number;
		private var _vx:Number;
		private var _vy:Number;
		
		private var _xAxe:Boolean;
		private var _yAxe:Boolean;
		
		private var _inited:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DuplicateLines( color:uint, linesCount:int, spacing:Number, inverted:Boolean = false, invertedGradient:Boolean = false, maxAlpha:Number = 1, diffX:Number = 0, diffY:Number = 0 ) 
		{
			this._color = color;
			this._linesCount = linesCount;
			this._spacing = spacing;
			this._inverted = inverted;
			this._invertedGradient = invertedGradient;
			this._maxAlpha = maxAlpha;
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
				
				_pieces = new Piece();
				
				_inited = true;
			}
			
			_g.clear();
			
			var percent:Number;
			var linesVal:Number;
			var piece:Piece = _pieces;
			while ( piece )
			{
				++piece.count;
				if ( piece.count >= _linesCount )
				{
					if ( !piece.next ) break;
					piece = piece.next;
					
					continue;
				}
				
				percent = piece.count * _maxAlpha / _linesCount;
				_g.lineStyle( 1, _color, _invertedGradient ? 1 - percent : percent );
				
				linesVal = _inverted ? ( _linesCount - piece.count ) : piece.count;
				
				_datas[ 0x0 ] = piece.x1 += _xAxe ? linesVal * ( _spacing * .1 ) : 0;
				_datas[ 0x1 ] = piece.y1 += _yAxe ? linesVal * ( _spacing * .1 ) : 0;
				
				_datas[ 0x2 ] = piece.x2 += _xAxe ? linesVal * ( _spacing * .1 ) : 0;
				_datas[ 0x3 ] = piece.y2 += _yAxe ? linesVal * ( _spacing * .1 ) : 0;
				
				_g.drawPath( _commands, _datas );
				
				if ( !piece.next ) break;
				piece = piece.next;
			}
			
			_g.lineStyle( 1, _color, piece.count / _linesCount );
			
			var newPiece:Piece = new Piece();
			
			newPiece.x1 = _px;
			newPiece.y1 = _py;
			
			_datas[ 0x0 ] = _px;
			_datas[ 0x1 ] = _py;
			
			_px -= _vx = ( _vx + ( _px - mx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			_py -= _vy = ( _vy + ( _py - my ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			newPiece.x2 = _px;
			newPiece.y2 = _py;
			
			_datas[ 0x2 ] = _px;
			_datas[ 0x3 ] = _py;
			
			piece.next = newPiece;
			
			_g.drawPath( _commands, _datas );
		}
		
		public function reset():void
		{
			_vx =
			_vy = 0;
			
			_inited = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get xAxe():Boolean { return _xAxe; }
		
		public function set xAxe(value:Boolean):void 
		{
			_xAxe = value;
		}
		
		public function get yAxe():Boolean { return _yAxe; }
		
		public function set yAxe(value:Boolean):void 
		{
			_yAxe = value;
		}
		
	}
	
}