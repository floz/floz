
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import fr.minuit4.games.tilebased.core.maps.Map;
	import fr.minuit4.games.tilebased.core.paths.pathfinding.Astar;
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	import fr.minuit4.games.tilebased.orientations.Orientation;
	import fr.minuit4.games.tilebased.scenes.grid.Grid;
	import fr.minuit4.geom.IntPoint;
	
	public class World extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _type:String;
		private var _map:Map;
		private var _astar:Astar;
		private var _world:Sprite;
		private var _grid:Grid;
		private var _gridRect:Rectangle;
		
		private var _showGrid:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function World( tileSize:int, datas:Vector.<Vector.<TileDatas>> = null, type:String = Orientation.ORTHOGONAL ) 
		{
			this._tileSize = tileSize;
			this._type = type;
			
			_map = new Map( datas );
			_astar = new Astar( _map );
			
			_world = new Sprite();
			addChild( _world );
			
			_grid = new Grid( _tileSize, _map, _type );
			_grid.visible = _showGrid;
			_world.addChild( _grid );
			
			_gridRect = _world.getBounds( _grid );
			
			replaceWorld();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function replaceWorld():void
		{
			_world.x = -_gridRect.x;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function findPath( start:Point, end:Point ):Vector.<IntPoint>
		{
			return _astar.findPath( start, end );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get datas():Vector.<Vector.<TileDatas>> { return _map.datas; }
		
		public function set datas( value:Vector.<Vector.<TileDatas>> ):void
		{
			_map.datas = value;
			
			_grid.refresh();
			_gridRect = _world.getBounds( _grid );
			
			replaceWorld();
		}
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize(value:int):void 
		{
			_tileSize = value;
		}
		
		public function get type():String { return _type; }
		
	}
	
}