
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import games.core.IntPoint;
	import games.paths.pathfinding.Astar;
	import games.scenes.grids.Grid;
	import games.scenes.maps.Map;
	import games.scenes.tiles.Tile;
	import games.scenes.types.RepresentationType;
	
	public class World extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _map:Map;
		private var _astar:Astar;
		private var _type:String;
		private var _grid:Grid;
		private var _gridRect:Rectangle;
		
		private var _isoWorld:Sprite;
		private var _showGrid:Boolean = false;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Crée un monde.
		 * @param	tileSize
		 * @param	datas
		 * @param	type
		 */
		public function World( tileSize:int, datas:Array, type:String = RepresentationType.NORMAL ) 
		{
			this._tileSize = tileSize;
			this._type = type;
			
			_map = new Map( datas );
			_astar = new Astar( _map );
			
			_isoWorld = new Sprite();
			addChild( _isoWorld );
			
			_grid = new Grid( tileSize, _map, type );
			_grid.visible = _showGrid;
			_isoWorld.addChild( _grid );
			
			_gridRect = _isoWorld.getBounds( _grid );
			
			replaceWorld();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function replaceWorld():void
		{
			_isoWorld.x = -_gridRect.x;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getTile( x:int, y:int ):Tile
		{
			return null;
		}
		
		public function getGridTile( x:int, y:int ):Tile
		{
			return _grid.getTile( x, y );
		}
		
		public function findPath( start:Point, end:Point ):Vector.<IntPoint>
		{
			return _astar.findPath( start, end );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize(value:int):void 
		{
			_tileSize = value;
			_grid.tileSize = _tileSize;
		}
		
		public function get type():String { return _type; }
		
		public function get showGrid():Boolean { return _showGrid; }
		
		public function set showGrid(value:Boolean):void 
		{
			_showGrid = value;
			_grid.visible = _showGrid;
		}
		
		override public function get mouseX():Number { return ( super.mouseX + _gridRect.x ); }
		
		public function get map():Map { return _map; }
		
	}
	
}