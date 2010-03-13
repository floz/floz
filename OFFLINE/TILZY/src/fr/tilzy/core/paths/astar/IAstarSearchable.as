
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.paths.astar 
{
	
	public interface IAstarSearchable 
	{
		function isWalkable( x:int, y:int ):Boolean;
		
		function get width():uint;
		function get height():uint;
	}
	
}