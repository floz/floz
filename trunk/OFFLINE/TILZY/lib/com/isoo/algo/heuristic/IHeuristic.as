package com.isoo.algo.heuristic 
{
	import com.isoo.algo.astar.AStarNode;
	
	/**
	 * ...
	 * @author David Ronai
	 */
	public interface IHeuristic 
	{
		function getCost( n1:AStarNode, n2:AStarNode ):Number;
	}
	
}