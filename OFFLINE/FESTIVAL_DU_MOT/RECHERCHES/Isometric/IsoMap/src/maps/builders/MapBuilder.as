
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps.builders 
{
	import maps.IMap;
	import maps.Tile;
	
	public class MapBuilder implements IMapBuilder
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _map:IMap;
		protected var _tiles:/*Array*/Array;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MapBuilder() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function build( map:IMap ):void
		{
			this._map = map;
			_tiles = [];
		}
		
		public function getTile( x:int, y:int ):Tile
		{
			return _tiles[ y, x ];
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}