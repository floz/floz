
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
		
		override protected function build():void 
		{
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
			g.beginFill( _color, .2 );
			g.moveTo( 0, 0 );
			g.lineTo( _size, 0 );
			g.lineTo( _size, _size );
			g.lineTo( 0, _size );
			g.lineTo( 0, 0 );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}