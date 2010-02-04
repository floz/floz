package pathing.heuristics 
{
	import maps.core.Node;
	
	public interface IHeuristic 
	{
		function getCost( a:Node, b:Node ):Number;
	}
	
}