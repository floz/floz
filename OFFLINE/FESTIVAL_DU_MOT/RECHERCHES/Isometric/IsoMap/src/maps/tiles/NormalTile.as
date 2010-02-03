
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.tiles 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	public class NormalTile extends Tile
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NormalTile( size:int ) 
		{
			super( size );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		final override protected function build():void 
		{
			var c:uint;
			if ( _selected && !_walkable ) c = 0x009999;
			else if ( _selected && _walkable ) c = 0x003333;
			else if ( !_selected && _walkable ) c = 0x444444;
			else c = 0xeeeeee;
			
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle( 1, 0x000000, 1, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER );
			g.beginFill( c );
			g.drawRect( 0, 0, _size, _size );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}