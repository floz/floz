package games.paths.pathfinding.heuristics
{
	
	public interface IHeuristic 
	{
		function getCost( x1:int, y1:int, x2:int, y2:int ):Number;
	}
	
}