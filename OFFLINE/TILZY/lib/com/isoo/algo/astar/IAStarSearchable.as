package com.isoo.algo.astar
{
	public interface IAStarSearchable
	{
		function isWalkable(x:int, y:int):Boolean;
		function get width():uint;
		function get height():uint;
	}
}