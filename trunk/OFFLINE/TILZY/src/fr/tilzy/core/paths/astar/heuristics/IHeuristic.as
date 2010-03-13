
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.paths.astar.heuristics
{
	
	public interface IHeuristic 
	{
		function getCost( x1:int, y1:int, x2:int, y2:int ):Number;
	}
	
}