
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.maps 
{
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	
	public interface IMap 
	{
		public function setDatasFromVector( datas:Vector.<Vector.<int>> ):void;
		
		public function setDatasFromArray( datas:Array ):void;
		
		public function isWalkable( x:int, y:int ):Boolean;
		
		public function isInside( x:int, y:int ):Boolean
		
		public function set datas( value:Vector.<Vector.<TileDatas>> ):void;
		
		public function get datas():Vector.<Vector.<TileDatas>>;
		
		public function get width():int;
		
		public function get height():int;
	}
	
}