
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.paths.pathfinding 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import games.core.IntPoint;
	import games.paths.pathfinding.heuristics.Diagonal;
	import games.paths.pathfinding.heuristics.IHeuristic;
	import games.scenes.maps.Map;
	
	public class Astar 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _map:Map;
		private var _width:int;
		private var _height:int;
		
		private var _nodes:Vector.<Vector.<Node>>;
		
		private var _startNode:Node;
		private var _endNode:Node;
		private var _openList:Vector.<Node>;
		private var _closedList:Vector.<Node>;
		
		private var _nodesPath:Dictionary = new Dictionary( true );
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static const STRAIGHT_COST:int = 10;
		public static const DIAG_COST:int = 14;
		
		public var heuristic:IHeuristic = new Diagonal();
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Astar( map:Map ) 
		{
			this._map = map;
			
			_width = _map.width;
			_height = _map.height;
			
			initNodes();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initNodes():void
		{
			_nodes = new Vector.<Vector.<Node>>( _height, true );
			
			var node:Node;
			var nodes:Vector.<Node>;
			var j:int;
			for ( var i:int; i < _height; ++i )
			{
				nodes = new Vector.<Node>( _width, true );
				for ( j = 0; j < _width; ++j )
				{
					node = new Node( j, i );
					node.walkable = _map.isWalkable( j, i );
					nodes[ j ] = node;
				}
				_nodes[ i ] = nodes;
			}
		}
		
		private function search():Vector.<IntPoint>
		{
			var testNode:Node;
			var node:Node = _startNode;
			
			var startX:int;
			var startY:int;
			var endX:int;
			var endY:int;
			
			var g:Number;
			var h:Number;
			var f:Number;
			var cost:Number;
			
			var x:int, y:int;	
			while ( node != _endNode )
			{
				startX = node.x - 1 < 0 ? 0 : node.x - 1;
				startY = node.y - 1 < 0 ? 0 : node.y - 1;
				endX = node.x + 1 > _width ? _width - 1 : node.x + 1;
				endY = node.y + 1 > _height ? _height - 1 : node.y + 1;
				
				for ( y = startY; y < endY; ++y )
				{
					for ( x = startX; x < endX; ++x )
					{
						if ( !_map.isWalkable( x, y ) || !_map.isWalkable( node.x, y ) || !_map.isWalkable( x, node.y ) )
							continue;
						
						testNode = _nodes[ y ][ x ];
						
						cost = STRAIGHT_COST;
						if ( node.x != testNode.x || node.y != testNode.y )
							cost = DIAG_COST;
						
						g = testNode.g + cost;
						h = heuristic.getCost( testNode.x, testNode.y, _endNode.x, _endNode.y );
						f = g + h;
						
						if ( hasNode( _openList, testNode ) || hasNode( _closedList, testNode ) )
						{
							if ( testNode.f > f )
							{
								testNode.g = g;
								testNode.h = h;
								testNode.f = f;
								testNode.parent = node;
							}
						}
						else
						{
							testNode.g = g;
							testNode.h = h;
							testNode.f = f;
							testNode.parent = node;
							
							_openList[ _openList.length ] = testNode;
						}
					}
				}
				_closedList[ _closedList.length ] = node;
				
				if ( _openList.length == 0 ) 
					return null;
				
				_openList = sortNodes( _openList );
				node = _openList.shift();
			}
			
			return getPath();
		}
		
		private function hasNode( list:Vector.<Node>, node:Node ):Boolean
		{
			var n:int = list.length;
			for ( var i:int; i < n; ++i )
				if ( list[ i ] == node ) return true;
			
			return false;
		}
		
		private function sortNodes( list:Vector.<Node> ):Vector.<Node>
		{
			var tmp:Node;
			
			var i:int;
			var n:int = list.length - 1;
			
			var sorted:Boolean = false;
			while ( !sorted )
			{
				sorted = true;
				for ( i = 0; i < n; ++i )
				{
					if ( list[ i ].f > list[ i + 1 ].f )
					{
						tmp = list[ i + 1 ];
						list[ i + 1 ] = list[ i ];
						list[ i ] = tmp;
						
						sorted = false;
					}
				}
			}
			
			return list;
		}
		
		private function getPath():Vector.<IntPoint>
		{
			trace("Astar.getPath");
			var nodes:Vector.<IntPoint> = new Vector.<IntPoint>();
			
			var p:IntPoint = new IntPoint( _endNode.x, _endNode.y );
			nodes[ 0 ] = p;
			
			var node:Node = _endNode;
			while ( node != _startNode )
			{
				node = node.parent;
				p = new IntPoint( node.x, node.y );
				nodes.unshift( p );
			}
			
			return nodes;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function findPath( start:Point, end:Point ):Vector.<IntPoint>
		{
			if ( !_map.isWalkable( start.x, start.y ) || !_map.isWalkable( end.x, end.y ) || ( start.x == end.x && start.y == end.y ) ) 
				return null;
			
			_openList = new Vector.<Node>();
			_closedList = new Vector.<Node>();
			
			_startNode = _nodes[ start.y ][ start.x ];
			_endNode = _nodes[ end.y ][ end.x ];
			
			_startNode.g = 0;
			_startNode.h = heuristic.getCost( start.x, start.y, end.x, end.y );
			_startNode.f = _startNode.g + _startNode.h;
			
			_openList[ 0 ] = _startNode;
			
			return search();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}

final internal class Node
{
	public var x:int;
	public var y:int;
	
	public var g:Number;
	public var h:Number;
	public var f:Number;
	
	public var walkable:Boolean;
	public var parent:Node;
	
	public function Node( x:int, y:int )
	{
		this.x = x;
		this.y = y;
	}
	
}