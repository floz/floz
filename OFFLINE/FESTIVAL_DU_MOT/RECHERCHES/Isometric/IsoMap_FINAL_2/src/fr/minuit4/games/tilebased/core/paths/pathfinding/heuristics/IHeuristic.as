
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.paths.pathfinding.heuristics
{
	
	public interface IHeuristic 
	{
		function getCost( x1:int, y1:int, x2:int, y2:int ):Number;
	}
	
}