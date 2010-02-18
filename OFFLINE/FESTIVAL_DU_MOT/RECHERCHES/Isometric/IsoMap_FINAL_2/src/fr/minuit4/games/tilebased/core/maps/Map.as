
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.core.maps 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	import games.paths.pathfinding.Astar;
	
	public class Map extends EventDispatcher implements IMap
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Vector.<Vector.<TileDatas>>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var width:int;
		public var height:int;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Contient toutes les données de la map dans un tableau à deux dimensions.
		 * @param	datas
		 */
		public function Map( datas:Vector.<Vector.<TileDatas>> = null ) 
		{
			this.datas = datas;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initMap():void
		{
			width = _datas[ 0 ].length;
			height = _datas.length;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function isWalkable( x:int, y:int ):Boolean
		{
			return ( isInside( x, y ) && _datas[ y ][ x ] == 0 );
		}
		
		public function isInside( x:int, y:int ):Boolean
		{
			return ( ( x >= 0 && x < _width ) && ( y >= 0 && y < _height ) );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get datas():Vector.<Vector.<TileDatas>> { return _datas; }
		
		public function set datas( value:Vector.<Vector.<TileDatas>> ):void
		{
			if ( value == null ) 
				return;
			
			_datas = value;
			initMap();
		}
		
	}
	
}