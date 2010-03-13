
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.isometric.objects 
{
	import flash.display.Sprite;
	import fr.minuit4.games.tilebased.core.maps.Map;
	import fr.minuit4.games.tilebased.common.materials.Material;
	import fr.minuit4.games.tilebased.common.materials.WireColorMaterial;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoPlane;
	
	public class IsoGrid extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _map:Map;
		
		private var _tiles:Vector.<Vector.<IsoObject>>
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoGrid( tileSize:int, map:Map ) 
		{
			this._tileSize = tileSize;
			this._map = map;
			
			if( _map.width && _map.height )
				build();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function build():void
		{
			destroy();
			
			var tile:IsoPlane;
			var material:Material;
			
			var px:Number = 0;
			var py:Number = 0;
			
			var v:Vector.<IsoObject>;
			
			var i:int;
			var j:int;
			for ( i = 0; i < _map.height; ++i )
			{
				v = new Vector.<IsoObject>( _map.width, true );
				_tiles[ i ] = v;
				
				px = 0;
				for ( j = 0; j < _map.width; ++j )
				{
					material = _map.isWalkable( j, i ) ? new WireColorMaterial( 0xeeeeee, .1, 0x000000, .1, 1 ) : new WireColorMaterial( 0x000000, .4, 0x000000, .3, 1 );
					tile = new IsoPlane( material, _tileSize );
					tile.x = px;
					tile.y = py;
					tile.cacheAsBitmap = true;
					addChild( tile );
					
					v[ j ] = tile;
					
					px += _tileSize;
				}
				py += _tileSize;
			}
		}
		
		private function destroy():void
		{
			while ( numChildren ) removeChildAt( 0 );
			_tiles = new Vector.<Vector.<IsoObject>>();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function refresh():void
		{
			build();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize(value:int):void 
		{
			_tileSize = value;
			build();
		}
		
	}
	
}