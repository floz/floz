package com.isoo.algo.heuristic 
{
	import com.isoo.algo.astar.AStarNode;
	import com.isoo.algo.heuristic.IHeuristic;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public class Euclidian implements IHeuristic
	{
		
		public function Euclidian() 
		{
			
		}
		
		public function getCost(n1:AStarNode, n2:AStarNode):Number
		{
			return Math.sqrt(Math.pow((n1.x-n2.x),2)+Math.pow((n1.y-n2.y),2));
		}
		
	}

}