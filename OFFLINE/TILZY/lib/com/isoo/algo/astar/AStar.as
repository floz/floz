package com.isoo.algo.astar
{
	import com.isoo.algo.geom.IntPoint;
	import com.isoo.algo.heuristic.Diagonal;
	import com.isoo.algo.heuristic.IHeuristic;
	
	import flash.utils.Dictionary;
		
	public class AStar
	{
		private var map:Array;
		private var width:int;
		private var height:int;
		
		private var start:AStarNode;
		private var goal:AStarNode;

		//nodes to considered or not anymore
		public var open:Array;
		public var closed:Array;
		
		// Euclidian is better, but slower 
		//private var dist:Function = distEuclidian;
		//private var dist:Function = distManhattan;
		//private var dist:Function = distDiagonal;
		
		private var heuristic:IHeuristic = new Diagonal();

		private var diagonal:Boolean;	
		public static const COST_ORTHOGONAL:int = 10;
		public static const COST_DIAGONAL:int = 10;
		
		/**
		 * Config Astar / Preprocessing
		 * @param 	map		The map to search
		 */
		function AStar( map:IAStarSearchable )
		{
			width = map.width;
			height = map.height;
			
			this.map = createMap(map);
		}		
		
		/**
		 * 	Find the path
		 * 
		 * 	@return	An vector of IntPoints with the path or null if path is imposible
		 */
		public function solve( startPoint:IntPoint, goalPoint:IntPoint, diagonal:Boolean = false ):Vector.<IntPoint>
		{
			// Path to solve
			start = new AStarNode(startPoint.x, startPoint.y);
			goal = new AStarNode(goalPoint.x, goalPoint.y); 
			this.diagonal = diagonal;
			
			// Solve
			open = [];
			closed = [];
			
			start.h = heuristic.getCost(start, goal);
			var node:AStarNode = start;
			open.push();
			
			var solved:Boolean = false;
			
			while(!solved) {					
				
				if (open.length <= 0) break;
				
				// Sort open list by cost
				open.sortOn("f",Array.NUMERIC);
				node = open.shift();
				closed.push(node);
				
				if (node.x == goal.x && node.y == goal.y) {
					solved = true;
					break;
				}
				
				var neighbor:Array = neighbors( node );
				var length:int = neighbor.length;
				var n:AStarNode;
				
				for (var i:int = 0; i < length; i++) {
					n = neighbor[i];
					if (!hasElement(open,n) && !hasElement(closed,n)) {
						open.push(n);
						n.parent = node;
						n.h = heuristic.getCost(n, goal);
						n.g = node.g;
					} else {
						var f:Number = n.g + node.g + n.h;
						if (f < n.f) {
							n.parent = node;
							n.g = node.g;
						}
					}
				}
			}
			
			if (solved) {
				var solution:Vector.<IntPoint> = new Vector.<IntPoint>();
				
				while (1) {
					solution.push(new IntPoint(node.x, node.y));
					if ((node = node.parent) == null)
						break;
				}
				return solution;
			} else {
				return null;
			}
		}
		
		/**
		 * 	Faster, more inaccurate heuristic method
		 */
		private function distManhattan(n1:AStarNode, n2:AStarNode = null):Number 
		{
			if (n2 == null) n2 = goal;
			return Math.abs(n1.x-n2.x)+Math.abs(n1.y-n2.y);
		}
		
		/**
		 * 	Slower but much better heuristic method. Actually,
		 * 	this returns just the distance between 2 points.
		 */
		private function distEuclidian(n1:AStarNode, n2:AStarNode = null):Number 
		{
			if (n2 == null) n2 = goal;
			return Math.sqrt(Math.pow((n1.x-n2.x),2)+Math.pow((n1.y-n2.y),2));
		}
		
		private function distDiagonal(n1:AStarNode, n2:AStarNode=null):Number
		{
			if (n2 == null) n2 = goal;
			var dx:Number = Math.abs(n1.x - n2.x);
			var dy:Number = Math.abs(n1.y - n2.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return COST_DIAGONAL * diag + COST_ORTHOGONAL * (straight - 2 * diag);
		}
		
		/**
		 * 	Return a node's neighbors, IF they're walkable
		 * 	@return An array of AStarNodes.
		 */
		private function neighbors(node:AStarNode):Array
		{
			var n:AStarNode;
			var a:Array = new Array();
			
			var starX:int = node.x -1 < 0 ? 0 : node.x -1;
			var starY:int = node.y -1 < 0 ? 0 : node.y -1;
			var endX:int =  node.x +1 > map[0].length-1 ? map[0].length-1 : node.x +1;
			var endY:int =  node.y +1 > map.length-1 ? map.length-1 : node.y +1;
			
			for ( var y:int = starY; y <= endY; y++ ) {
				for ( var x:int = starX; x <= endX; x++) {
					n = map[x][y];
					if ( n.walkable && n != node ){
						n.g += COST_ORTHOGONAL;
						a.push(n);
					}
				}
			}
			
			return a;
		}
		
		/**
		 * Create a map with cost and heuristic values for each tile
		 */
		private function createMap(map:IAStarSearchable):Array
		{
			var a:Array = new Array(width);
			for (var x:int=0; x<width; x++) {
				a[x] = new Array(height);
				for (var y:int=0; y<height; y++) {
					a[x][y] = new AStarNode(x,y,map.isWalkable(x,y));
				}
			}
			return a;
		}
		
		/**
		 * Checks if a given array contains the object specified.
		 * 
		 */
		private static function hasElement(a:Array, e:Object):Boolean
		{
			var l:Number = a.length;
			for ( var i:int = 0; i < a.length; i++) {
				if ( e == a[i] )
					return true;
			}
			return false;
		}
		
		/**
		 * Remove an element from an array
		 */
		private static function removeFromArray(a:Array, e:Object):Boolean
		{
			for (var i:int=0; i<a.length; i++) {
				if (a[i] == e) {
					a.splice(i,1);
					return true;
				}
			}
			return false;
		}
	}
}