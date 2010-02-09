
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pathing 
{
	import flash.geom.Point;
	import flash.utils.getTimer;
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
		private const DIAG_COST:Number = Math.SQRT2;
		
		private var _map:IMap;
		private var _openList:/*Node*/Array;
		private var _closedList:/*Node*/Array;
		
		private var _nodes:/*Array*/Array;		
		private var _row:int;
		private var _columns:int;
		
		private var _startNode:Node;
		private var _endNode:Node;	
		
		private var _heuristic:IHeuristic = new Diagonal();
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AstarAlgorithm( map:IMap )
		{
			this._map = map;
			
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
		
		private function search():Boolean 
		{
			var n:Node;
			
			var node:Node = _startNode;
			while ( node != _endNode )
			{
				var startX:int = node.x - 1 < 0 ? 0 : node.x - 1;
				var startY:int = node.y - 1 < 0 ? 0 : node.y - 1;
				var endX:int = node.x + 1 >= _row ? _row - 1 : node.x + 1;
				var endY:int = node.y + 1 >= _columns ? _columns - 1 : node.y + 1;
				
				var cost:Number;
				
				var g:Number;
				var h:Number;
				var f:Number;
				
				var x:int, y:int;
				for ( y = startY; y < endY + 1; ++y )
				{
					for ( x = startX; x < endX + 1; ++x )
					{
						n = _nodes[ y ][ x ];
						if ( !n.walkable || n == node || !_nodes[ y ][ node.x ].walkable || !_nodes[ node.y ][ x ].walkable ) continue;
						
						cost = STRAIGHT_COST;
						if ( !((  node.x == n.x ) || ( node.y == n.y ) ) )
							cost = DIAG_COST;							
						
						g = node.g + cost;
						h = _heuristic.getCost( n, _endNode );
						f = g + h;
						
						if ( isOpen( n ) || isClosed( n ) )
						{
							if ( n.f > f )
							{	
								n.f = f;
								n.g = g;
								n.h = h;
								n.parent = node;
							}
						}
						else
						{
							n.g = g;
							n.h = h;
							n.f = f;
							n.parent = node;
							_openList.push( n );
						}
					}
				}
				_closedList.push( node );
				
				if ( !_openList.length ) return false;
				
				_openList.sortOn( "f", Array.NUMERIC );
				node = _openList.shift();
			}
			return true;
		}
		
		private function isOpen( node:Node ):Boolean
		{
			var n:int = _openList.length;
			for ( var i:int; i < n; ++i )
				if ( _openList[ i ] == node ) return true;
			
			return false;
		}
		
		private function isClosed( node:Node ):Boolean
		{
			var n:int = _closedList.length;
			for ( var i:int; i < n; ++i )
				if ( _closedList[ i ] == node ) return true;
			
			return false;
		}
		
		private function getPath():Array
		{
			var a:Array = [];
			
			var node:Node = _endNode;
			a.push( node );
			while ( node != _startNode )
			{
				node = node.parent;
				a.unshift( node );
			}
			
			return a;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function findPath( a:Point, b:Point ):Array
		{
			_openList = [];
			_closedList = [];
			
			_startNode = _nodes[ a.y ][ a.x ];
			_endNode = _nodes[ b.y ][ b.x ];
			if ( !_startNode || !_endNode ) return null;
			if ( !_startNode.walkable ) return null;
			
			_startNode.g = 0;
			_startNode.h = _heuristic.getCost( _startNode, _endNode );
			_startNode.f = _startNode.g + _startNode.h;
			
			_openList.push( _startNode );
			
			if ( search() ) 
				return getPath();
			
			return null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}