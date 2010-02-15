
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes.tiles.primitives 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import games.scenes.tiles.Tile;
	
	public class Tile2D extends Tile
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tile2D( size:int ) 
		{
			super( size );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function updateDatas():void
		{
			_datas[ 0 ] = 0;
			_datas[ 1 ] = 0;
			
			_datas[ 2 ] = _size;
			_datas[ 3 ] = 0;
			
			_datas[ 4 ] = _size;
			_datas[ 5 ] = _size;
			
			_datas[ 6 ] = 0;
			_datas[ 7 ] = _size;
			
			_datas[ 8 ] = 0;
			_datas[ 9 ] = 0;
		}
		
		override protected function build():void 
		{
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
			g.beginFill( _color, .2 );
			g.drawPath( _COMMANDS, _datas );
			trace("_COMMANDS : " + _COMMANDS);
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}