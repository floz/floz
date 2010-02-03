
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.tiles 
{
	import maps.core.Node;
	
	public class Tile extends Node implements ITile
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _size:int;
		protected var _selected:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tile( size:int ) 
		{
			this._size = size;
			build();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function build():void
		{
			// ASBTRACT
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			build();
		}
		
		override public function set walkable(value:Boolean):void 
		{
			super.walkable = value;
			build();
		}
		
	}
	
}