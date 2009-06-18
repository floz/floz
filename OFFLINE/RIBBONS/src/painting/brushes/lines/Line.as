
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.brushes.lines 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import painting.brushes.AbstractBrush;
	import painting.brushes.BrushDatas;
	import painting.events.PaintingEvent;
	import painting.interfaces.IBrush;
	
	public class Line extends AbstractBrush
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const _commands:Vector.<int> = Vector.<int>( [ GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO ] );
		private const _datas:Vector.<Number> = new Vector.<Number>( 4, true );
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static var FRICTION:Number = .8;
		public static var SLOWDOWN:Number = .05;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Line( colors:Vector.<uint>, alphas:Vector.<Number>, diffX:Number = 0, diffY:Number = 0 ) 
		{
			super( colors, alphas, diffX, diffY );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function drawSequence():void
		{
			var line:BrushDatas = _core;
			var g:Graphics = line.brush.graphics;
			
			++line.colorsIdx;
			++line.alphasIdx;
			
			g.clear();
			g.lineStyle( 1, line.colors[ line.colorsIdx ], line.alphas[ line.alphasIdx ] );
			g.drawPath( _commands, _datas );
			
			line.canvas.draw( line.brush );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public override function paint(mx:Number, my:Number):void 
		{
			if ( !_enabled )
				return;
			
			var line:BrushDatas = _core;
			
			if ( !line.px )
			{
				line.px = mx;
				line.py = my;
			}
			
			_datas[ 0x0 ] = line.px;
			_datas[ 0x1 ] = line.py;
			
			line.vx = ( line.vx + ( line.px - mx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			line.vy = ( line.vy + ( line.py - my ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			line.px -= line.vx;
			line.py -= line.vy;
			
			_datas[ 0x2 ] = line.px;
			_datas[ 0x3 ] = line.py;
			
			drawSequence();
		}
		
		public override function completePainting():int 
		{
			if ( !_enabled )
				return 0;
			
			var line:BrushDatas = _core;
			
			_datas[ 0x0 ] = line.px;
			_datas[ 0x1 ] = line.py;
			
			line.vx = ( line.vx + ( line.px - line.dx ) * SLOWDOWN ) * ( FRICTION + _diffX );
			line.vy = ( line.vy + ( line.py - line.dy ) * SLOWDOWN ) * ( FRICTION + _diffY );
			
			line.px -= line.vx;
			line.py -= line.vy;
			
			var dx:Number = ( line.dx - line.px );
			var dy:Number = ( line.dy - line.py );
			var dist:Number = Math.sqrt( dx * dx + dy * dy );
			
			if ( dist < .1 )
			{
				var paintingEvent:PaintingEvent = new PaintingEvent( PaintingEvent.BRUSH_COMPLETE );
				paintingEvent.instance = this.parent as Sprite;
				dispatchEvent( paintingEvent );
				
				//line.graphics.clear();
				
				return 0;
			}
			
			_datas[ 0x2 ] = line.px;
			_datas[ 0x3 ] = line.py;
			
			drawSequence();
			
			return 1;
		}
		
		public override function copy():IBrush 
		{
			return new Line( _colors, _alphas, _diffX, _diffY );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}