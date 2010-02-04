
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.tiles 
{
	import flash.display.Sprite;
	import maps.core.Node;
	
	public class Tile extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _size:int;
		//protected var _node:Node;
		protected var _walkable:Boolean;		
		protected var _selected:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tile( size:int ) 
		{
			this._size = size;
			//_node = new Node();
			
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
		
		public function get walkable():Boolean { return _walkable; }
		
		public function set walkable(value:Boolean):void 
		{
			_walkable = value;
			build();
		}
		
		//public function get node():Node { return _snode; }
		
	}
	
}