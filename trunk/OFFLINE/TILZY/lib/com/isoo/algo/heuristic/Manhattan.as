package com.isoo.algo.heuristic 
{
	import com.isoo.algo.astar.AStarNode;
	import com.isoo.algo.heuristic.IHeuristic;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public class Manhattan implements IHeuristic
	{
		
		public function Manhattan() 
		{
			
		}
		
		public function getCost(n1:AStarNode, n2:AStarNode):Number
		{
			return Math.abs(n1.x-n2.x)+Math.abs(n1.y-n2.y);
		}
		
	}

}