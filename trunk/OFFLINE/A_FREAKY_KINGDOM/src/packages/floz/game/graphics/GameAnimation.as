
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package floz.game.graphics 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;

	public class GameAnimation 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _frames:/*BitmapData*/Array;
		private var _idx:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function GameAnimation() 
		{
			_frames = [];
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function addFrame( frame:DisplayObject ):void
		{
			var mx:Matrix = new Matrix();
			mx.translate( -frame.getBounds( frame ).x, -frame.getBounds( frame ).y );
			var bd:BitmapData = new BitmapData( frame.width, frame.height, true, 0x00 );
			bd.draw( frame, mx );
			
			_frames.push( bd );
		}
		
		public function render():BitmapData
		{
			var bd:BitmapData = _frames[ _idx ];
			_idx = int( _idx + 1 ) > int( _frames.length - 1 ) ? 0 : int( _idx + 1 );
			return bd;
		}
		
		public function stop():void
		{
			_idx = 0;
		}
		
		public function dispose():void
		{
			var n:int = _frames.length;
			for ( var i:int; i < n; ++i )
			{
				_frames[ i ].dispose();
				_frames[ i ] = null;
			}
			_frames = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}