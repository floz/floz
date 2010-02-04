
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pathing 
{
	import flash.geom.Point;
	import maps.core.Node;
	import maps.IMap;
	import pathing.heuristics.Euclidian;
	import pathing.heuristics.IHeuristic;
	
	public class AstarAlgorithm 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const STRAIGHT_COST:Number = 1;
		private const DIAG_COST:Number = Math.SQRT2;
		
		private var _map:IMap;
		private var _openList:/*Node*/Array;
		private var _closedList:/*Node*/Array;
		
		private var _nodes:/*Array*/Array;		
		private var _row:int;
		private var _columns:int;
		
		private var _startNode:Node;
		private var _endNode:Node;	
		
		private var _heuristic:IHeuristic = new Euclidian();
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AstarAlgorithm( map:IMap )
		{
			this._map = map;
			
			_openList = [];
			_closedList = [];
			
			createNodes();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createNodes():void
		{
			var node:Node;
			
			_nodes = [];
			var a:Array = [];
			
			var mapDatas:Array = _map.mapDatas;
			var n:int = mapDatas.length;
			var j:int, m:int;
			for ( var i:int; i < n; ++i )
			{
				for ( j = 0; j < m; ++j )
				{
					node = new Node( j, i );
					node.walkable = mapDatas[ j ][ i ] == 0 ? true : false;
					a.push( node );
				}
				_nodes.push( a );
			}
			
			_row = m;
			_columns = n;
		}
		
		private function search():Boolean // Boolean ou node ?
		{
			
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function findPath( a:Point, b:Point ):Boolean
		{
			_startNode = _nodes[ a.y ][ a.x ];
			_endNode = _nodes[ b.y ][ b.x ];
			
			_startNode.g = 0;
			_startNode.h = _heuristic.getCost( _startNode, _endNode );
			_startNode.f = _startNode.g + _startNode.h;
			
			return search();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}