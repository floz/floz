
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.maps 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import fr.tilzy.core.paths.astar.IAstarSearchable;
	import fr.tilzy.core.tiles.TileDatas;
	
	public class Map extends EventDispatcher implements IAstarSearchable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Vector.<Vector.<TileDatas>>;
		private var _width:uint;
		private var _height:uint;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Contient toutes les données de la map dans un tableau à deux dimensions.
		 * @param	datas	Vector.<Vector.<TileDatas>>
		 */
		public function Map( datas:Vector.<Vector.<TileDatas>> = null ) 
		{
			this.datas = datas;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initMap():void
		{
			_width = _datas[ 0 ].length;
			_height = _datas.length;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function isWalkable( x:int, y:int ):Boolean
		{
			return ( isInside( x, y ) && _datas[ y ][ x ].walkable );
		}
		
		public function isInside( x:int, y:int ):Boolean
		{
			return ( ( x >= 0 && x < width ) && ( y >= 0 && y < height ) );
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
		
		public function get width():uint { return _width; }
		
		public function get height():uint { return _height; }
		
		
		
	}
	
}