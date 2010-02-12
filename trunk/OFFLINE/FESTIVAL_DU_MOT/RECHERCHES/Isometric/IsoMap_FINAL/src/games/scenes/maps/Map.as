
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
		
		private var _width:int;
		private var _height:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Map( datas:Array ) 
		{
			this._datas = datas;
			
			_width = _datas[ 0 ].length;
			_height = _datas.length;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function isWalkable( x:int, y:int ):Boolean
		{
			return ( isInside( x, y ) && ( _datas[ y ][ x ] == 0 ) );
		}
		
		public function isInside( x:int, y:int ):Boolean
		{
			return ( ( x >= 0 && x < _width ) && ( y >= 0 && y < _height ) );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get datas():Array { return _datas; }
		
		public function get width():int { return _width; }
		
		public function get height():int { return _height; }
		
	}
	
}