
/**
 * @author Floz
 */
package  
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Point;
	
	public class Brush extends Shape
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _opx:Number;
		protected var _opy:Number;
		protected var _g:Graphics;
		
		protected var _initialized:Boolean;
		
		protected var _ticks:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Brush() 
		{
			_g = this.graphics;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function onFirstUpdate( px:Number, py:Number ):void
		{
			_initialized = true;
			
			_g.lineStyle( 1, 0x000000 );
			_g.moveTo( px, py );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update( px:Number, py:Number ):void
		{
			if ( !_initialized )
				onFirstUpdate( px, py );
			
			_g.lineTo( px, py );
			//if ( !( _ticks % 2 ) )
			//{
				//_opx = px;
				//_opy = py;
			//}
			//else
			//{
				//_g.curveTo( _opx, _opy, px, py );
			//}
			
			++_ticks;
		}
		
		public function stop():void
		{
			_initialized = false;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}