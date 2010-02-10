
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes 
{
	import flash.display.Sprite;
	import games.scenes.grids.Grid;
	import games.scenes.maps.Map;
	import games.scenes.types.RepresentationType;
	
	public class World extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _map:Map;
		private var _type:String;
		private var _grid:Grid;
		
		private var _showGrid:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function World( tileSize:int, datas:Array, type:String = RepresentationType.NORMAL ) 
		{
			this._tileSize = tileSize;
			this._type = type;
			
			_map = new Map( datas );
			
			_grid = new Grid( tileSize, datas, type );
			addChild( _grid );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize(value:int):void 
		{
			_tileSize = value;
		}
		
		public function get type():String { return _type; }
		
		public function get showGrid():Boolean { return _showGrid; }
		
		public function set showGrid(value:Boolean):void 
		{
			_showGrid = value;
		}
		
	}
	
}