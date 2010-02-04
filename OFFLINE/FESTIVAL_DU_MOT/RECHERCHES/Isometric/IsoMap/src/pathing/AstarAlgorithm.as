
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
	import pathing.heuristics.Diagonal;
	import pathing.heuristics.Euclidian;
	import pathing.heuristics.IHeuristic;
	import pathing.heuristics.Manhattan;
	
	public class AstarAlgorithm 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private const STRAIGHT_COST:Number = 1;
		private const DIAG_COST:Number = Math.SQRT2 + .3;
		
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
			var a:Array;
			
			var mapDatas:Array = _map.mapDatas;
			var n:int = mapDatas.length;
			var x:int, y:int, m:int;
			for ( y; y < n; ++y )
			{
				a = [];
				m = mapDatas[ y ].length;
				for ( x = 0; x < m; ++x )
				{
					node = new Node( x, y );
					node.walkable = mapDatas[ y ][ x ] == 0 ? true : false;
					a.push( node );
				}
				_nodes.push( a );
			}
			
			_row = m;
			_columns = n;
		}
		
		private function search( node:Node ):Node 
		{
			var startX:int = node.x - 1 < 0 ? 0 : node.x - 1;
			var startY:int = node.y - 1 < 0 ? 0 : node.y - 1;
			var endX:int = node.x + 1 >= _row ? _row - 1 : node.x + 1;
			var endY:int = node.y + 1 >= _columns ? _columns - 1 : node.y + 1;
			
			var isDiag:Boolean;
			var cost:Number;
			var n:Node;
			var bestNode:Node;
			
			var x:int, y:int;
			for ( y = startY; y < endY + 1; ++y )
			{
				for ( x = startX; x < endX + 1; ++x )
				{
					n = _nodes[ y ][ x ];
					if ( !n.walkable || n.closed || n == node || !_nodes[ y ][ node.x ].walkable || !_nodes[ node.y ][ x ].walkable ) continue;
					
					n.parent = node; 
					if ( n == _endNode ) return n; // On a trouvé la _endNode !
					
					isDiag = false;
					if ( x == node.x - 1 && y == node.y - 1 )
					{
						cost = DIAG_COST;
					}
					else if ( x == node.x + 1 && y == node.y - 1 )
					{
						cost = DIAG_COST;
					}
					else if ( x == node.x + 1 && y == node.y + 1 )
					{
						cost = DIAG_COST;
					}
					else if ( x == node.x - 1 && y == node.y + 1 )
					{
						cost = DIAG_COST;
					}
					else 
					{
						cost = STRAIGHT_COST;
					}
					
					n.g = node.g + cost;
					n.h = _heuristic.getCost( n, _endNode );
					n.f = n.g + n.h;
					
					if ( !bestNode || n.f < bestNode.f ) bestNode = n;
				}
			}
			
			if( bestNode ) _map.getTile( bestNode.x, bestNode.y ).selected = true;
			
			return null;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function findPath( a:Point, b:Point ):Node
		{
			_startNode = _nodes[ a.y ][ a.x ];
			_endNode = _nodes[ b.y ][ b.x ];
			
			_startNode.g = 0;
			_startNode.h = _heuristic.getCost( _startNode, _endNode );
			_startNode.f = _startNode.g + _startNode.h;
			
			return search( _startNode );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}