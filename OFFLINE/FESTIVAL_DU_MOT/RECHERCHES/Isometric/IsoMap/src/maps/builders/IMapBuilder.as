﻿
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.builders 
{
	import maps.IMap;
	import maps.tiles.ITile;
	
	public interface IMapBuilder 
	{
		function build( map:IMap ):void;
		function getTile( x:int, y:int ):ITile;
	}
	
}