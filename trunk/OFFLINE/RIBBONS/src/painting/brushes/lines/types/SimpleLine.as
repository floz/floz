
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.lines.types
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import painting.brushes.lines.PooledLine;
	import painting.interfaces.IBrush;
	
	public class SimpleLine extends Sprite implements IBrush
	{
		
		// - STATIC ----------------------------------------------------------------------
		
		public static var FRICTION:Number = .8;
		public static var SLOWDOWN:Number = .05;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const _commands:Vector.<int> = Vector.<int>( [ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO ] );
		private const _datas:Vector.<Number> = new Vector.<Number>( 4, true );
		
		private var _colors:Vector.<uint>;
		private var _alphas:Vector.<Number>;
		private var _diffX:Number;
		private var _diffY:Number;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function SimpleLine( colors:Vector.<uint>, alphas:Vector.<Number>, diffX:Number = 0, diffY:Number = 0 ) 
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
		
		public function paint( mx:Number, my:Number ):void
		{
			if ( !currentLine )
				addChild( PooledLine.create( _colors, _alphas ) );
			
			var line:PooledLine = currentLine;
			var g:Graphics = line.graphics;
			
			if ( !line.px )
			{
				line.px = mx;
				line.py = my;
			}
			
			++line.colorsIdx;
			++line.alphasIdx;
			
			g.clear();
			g.lineStyle( 1, line.colors[ line.colorsIdx ], line.alphas[ line.alphasIdx ] );
			
			_datas[ 0x0 ] = line.px;
			_datas[ 0x1 ] = line.py;
			
			line.vx = ( line.vx + ( line.px - mx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			line.vy = ( line.vy + ( line.py - my ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			line.px -= line.vx;
			line.py -= line.vy;
			
			_datas[ 0x2 ] = line.px;
			_datas[ 0x3 ] = line.py;
			
			g.drawPath( _commands, _datas );
		}
		
		public function completePainting():int
		{
			if ( !hasLine() )
				return 0;
			
			var line:PooledLine;
			var g:Graphics;
			
			var dx:Number;
			var dy:Number;
			var dist:Number;
			
			var i:int = getLinesCount() - 1;
			while ( --i > -1 )
			{
				line = getChildAt( i ) as PooledLine;
				
				++line.colorsIdx;
				++line.alphasIdx;
				
				g = line.graphics;
				g.clear();
				g.lineStyle( 1, line.colors[ line.colorsIdx ], line.alphas[ line.alphasIdx ] );
				
				_datas[ 0x0 ] = line.px;
				_datas[ 0x1 ] = line.py;
				
				line.vx = ( line.vx + ( line.px - line.dx ) * SLOWDOWN ) * ( FRICTION + _diffX );
				line.vy = ( line.vy + ( line.py - line.dy ) * SLOWDOWN ) * ( FRICTION + _diffY );
				
				line.px -= line.vx;
				line.py -= line.vy;
				
				_datas[ 0x2 ] = line.px;
				_datas[ 0x3 ] = line.py;
				
				dx = ( line.dx - line.px );
				dy = ( line.dy - line.py );
				dist = Math.sqrt( dx * dx + dy * dy );
				
				if ( dist < .1 )
				{
					line.dispose();
					removeChild( line );
					continue;
				}
				
				g.drawPath( _commands, _datas );
			}
			
			return int( getLinesCount() - 1 );
		}
		
		public function reset( mx:Number, my:Number ):void
		{
			currentLine.dx = mx;
			currentLine.dy = my;
			
			addChild( PooledLine.create( _colors, _alphas ) );
		}
		
		public function setColors( colors:Vector.<uint> ):void
		{
			_colors = colors;
			if ( !currentLine ) return;
			currentLine.colors = colors;
		}
		
		public function setAlphas( alphas:Vector.<Number> ):void
		{
			_alphas = alphas;
			if ( !currentLine ) return;
			currentLine.alphas = alphas;
		}
		
		public function getLinesCount():int
		{
			return this.numChildren;
		}
		
		public function hasLine():Boolean
		{
			return this.numChildren ? true : false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get currentLine():PooledLine
		{
			if ( !numChildren ) return null;
			return getChildAt( int( numChildren - 1 ) ) as PooledLine;
		}
		
	}
	
}