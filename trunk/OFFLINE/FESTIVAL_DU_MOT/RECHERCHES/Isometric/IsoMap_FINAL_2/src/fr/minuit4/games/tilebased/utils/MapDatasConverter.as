
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.utils 
{
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	
	public class MapDatasConverter 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function fromArray( datas:/*Array*/Array ):Vector.<TileDatas>
		{
			var tiles:Vector.<Vector.<TileDatas>> = new Vector.<Vector.<TileDatas>>( datas.length, true );
			
			var t:TileDatas;
			var v:Vector.<TileDatas>;
			
			var i:int, j:int, m:int;
			var n:int = datas.length;
			for ( ; i < n; ++i )
			{
				v = new Vector.<TileDatas>( datas[ i ].length, true );
				for ( j = 0; j < m; ++j )
				{
					t = new TileDatas( j, i, datas[ i ][ j ] );					
					v[ j ] = t;
				}
				tiles[ i ] = v;
			}
			
			return tiles;
		}
		
		public static function fromVector( datas:Vector.<Vector.<int>> ):Vector.<TileDatas>
		{
			var tiles:Vector.<Vector.<TileDatas>> = new Vector.<Vector.<TileDatas>>( datas.length, true );
			
			var t:TileDatas;
			var v:Vector.<TileDatas>;
			
			var i:int, j:int, m:int;
			var n:int = datas.length;
			for ( ; i < n; ++i )
			{
				v = new Vector.<TileDatas>( datas[ i ].length, true );
				for ( j = 0; j < m; ++j )
				{
					t = new TileDatas( j, i, datas[ i ][ j ] );					
					v[ j ] = t;
				}
				tiles[ i ] = v;
			}
			
			return tiles;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}