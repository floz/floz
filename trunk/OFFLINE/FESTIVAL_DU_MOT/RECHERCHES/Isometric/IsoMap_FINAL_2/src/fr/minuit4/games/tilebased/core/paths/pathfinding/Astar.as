
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.paths.pathfinding 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import games.core.IntPoint;
	import games.paths.pathfinding.heuristics.Diagonal;
	import games.paths.pathfinding.heuristics.Euclidian;
	import games.paths.pathfinding.heuristics.IHeuristic;
	import games.paths.pathfinding.heuristics.Manhattan;
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
		private var _openList:Array;
		private var _closedList:Array;
		
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
			
			var nodeFound:Boolean;
			
			var x:int, y:int;
			while ( !nodeFound )
			{
				startX = node.x - 1 < 0 ? 0 : node.x - 1;
				startY = node.y - 1 < 0 ? 0 : node.y - 1;
				endX = node.x + 1 >= _width ? _width - 1 : node.x + 1;
				endY = node.y + 1 >= _height ? _height - 1 : node.y + 1;
				
				for ( y = startY; y <= endY; ++y )
				{
					for ( x = startX; x <= endX; ++x )
					{
						testNode = _nodes[ y ][ x ];
						
						if ( testNode == node || !testNode.walkable || !_map.isWalkable( node.x, y ) || !_map.isWalkable( x, node.y ) )
							continue;
						
						cost = STRAIGHT_COST;
						if ( !( node.x == testNode.x || node.y == testNode.y ) )
							cost = DIAG_COST;
						
						g = node.g + cost;
						f = g + heuristic.getCost( testNode.x, testNode.y, _endNode.x, _endNode.y );
						
						if ( _openList.indexOf( testNode ) != -1 || _closedList.indexOf( testNode ) != -1 )
						{
							if ( testNode.f > f )
							{
								testNode.f = f;
								testNode.g = g;								
								testNode.parent = node;
							}
						}
						else
						{
							testNode.g = g;
							testNode.f = f;
							testNode.parent = node;
							
							_openList[ _openList.length ] = testNode;
						}
					}
				}
				_closedList[ _closedList.length ] = node;
				
				if ( _openList.length == 0 ) 
					return null;
				
				_openList.sortOn( "f", Array.NUMERIC );
				node = _openList.shift();
				
				if ( node == _endNode ) 
					nodeFound = true;
			}
			
			return getPath();
		}
		
		private function getPath():Vector.<IntPoint>
		{
			var nodes:Vector.<IntPoint> = new Vector.<IntPoint>();
			
			var p:IntPoint = new IntPoint( _endNode.x, _endNode.y );
			nodes[ 0 ] = p;
			
			var startNodeReached:Boolean;
			
			var node:Node = _endNode;
			while ( !startNodeReached )
			{
				node = node.parent;
				p = new IntPoint( node.x, node.y );
				nodes.unshift( p );
				
				if ( node == _startNode )
					startNodeReached = true;
			}
			
			return nodes;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function findPath( start:Point, end:Point ):Vector.<IntPoint>
		{
			if ( !_map.isWalkable( start.x, start.y ) || !_map.isWalkable( end.x, end.y ) || ( start.x == end.x && start.y == end.y ) ) 
				return null;
			
			_openList = [];
			_closedList = [];
			
			_startNode = _nodes[ start.y ][ start.x ];
			_endNode = _nodes[ end.y ][ end.x ];
			
			_startNode.g = 0;
			_startNode.f = heuristic.getCost( start.x, start.y, end.x, end.y );
			
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
	
	public var g:Number = 0;
	public var f:Number = 0;
	
	public var walkable:Boolean;
	public var parent:Node;
	
	public function Node( x:int, y:int )
	{
		this.x = x;
		this.y = y;
	}
	
	public function toString():String
	{
		return "Node[ x : " + x + ", y : " + y + "]";
	}
	
}