package com.isoo.algo.heuristic 
{
	import com.isoo.algo.astar.AStar;
	import com.isoo.algo.astar.AStarNode;
	import com.isoo.algo.heuristic.IHeuristic;
	
	/**
	 * 
	 * @author David Ronai
	 */
	public class Diagonal implements IHeuristic
	{
		
		public function Diagonal() 
		{
			
		}
		
		public function getCost(n1:AStarNode, n2:AStarNode):Number
		{
			var dx:Number = Math.abs(n1.x - n2.x);
			var dy:Number = Math.abs(n1.y - n2.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return AStar.COST_DIAGONAL * diag + AStar.COST_ORTHOGONAL * (straight - 2 * diag);
		}
		
	}

}