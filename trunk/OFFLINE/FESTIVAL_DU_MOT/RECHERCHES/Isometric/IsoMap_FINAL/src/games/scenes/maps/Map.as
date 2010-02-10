
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes.maps 
{
	import flash.geom.Point;
	import games.paths.pathfinding.Astar;
	
	public class Map 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Array;
		private var _astar:Astar;
		
		private var _width:int;
		private var _height:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Map( datas:Array ) 
		{
			this.datas = datas;
			this._astar = new Astar( this );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function isWalkable( x:int, y:int ):Boolean
		{
			if ( x < 0 || x >= _width || y < 0 || y >= _height ) return false;
			return ( _datas[ y ][ x ] == 0 );
		}
		
		public function findPath( start:Point, end:Point ):void
		{
			// TODO renvoyer le chemin, quel type ?
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get datas():Array { return _datas; }
		
		public function set datas( value:Array ):void 
		{
			_datas = value;
			
			_width = _datas[ 0 ].length;
			_height = _datas.length;
		}
		
	}
	
}