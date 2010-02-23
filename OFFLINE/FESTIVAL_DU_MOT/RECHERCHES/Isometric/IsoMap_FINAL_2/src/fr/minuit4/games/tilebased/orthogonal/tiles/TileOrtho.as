
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.orthogonal.tiles 
{
	import fr.minuit4.games.tilebased.common.materials.Material;
	import fr.minuit4.games.tilebased.common.tiles.Tile;
	
	public class TileOrtho extends Tile
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TileOrtho( material:Material, size:int ) 
		{
			super( material, size );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function initDatas():void 
		{
			_DATAS[ 0 ] = 0;
			_DATAS[ 1 ] = 0;
			
			_DATAS[ 2 ] = _size;
			_DATAS[ 3 ] = 0;
			
			_DATAS[ 4 ] = _size;
			_DATAS[ 5 ] = _size;
			
			_DATAS[ 6 ] = 0;
			_DATAS[ 7 ] = _size;
			
			_DATAS[ 8 ] = 0;
			_DATAS[ 9 ] = 0;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}