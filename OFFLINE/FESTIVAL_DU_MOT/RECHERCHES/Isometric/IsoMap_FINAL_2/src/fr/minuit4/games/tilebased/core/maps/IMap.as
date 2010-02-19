
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.maps 
{
	import flash.events.IEventDispatcher;
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	
	public interface IMap extends IEventDispatcher
	{
		function isWalkable( x:int, y:int ):Boolean;
		
		function isInside( x:int, y:int ):Boolean
		
		function set datas( value:Vector.<Vector.<TileDatas>> ):void;
		
		function get datas():Vector.<Vector.<TileDatas>>;
		
		function get width():int;
		
		function get height():int;
	}
	
}