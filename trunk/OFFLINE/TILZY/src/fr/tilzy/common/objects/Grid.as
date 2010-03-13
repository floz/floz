
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.common.objects 
{
	import flash.display.Sprite;
	import fr.tilzy.core.maps.Map;
	
	public class Grid extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _tileSize:int;
		protected var _map:Map;
		
		protected var _tiles:Vector.<Vector.<GameObject>>
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Grid( tileSize:int, map:Map ) 
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
			
			var tile:GameObject;
			
			var px:Number = 0;
			var py:Number = 0;
			
			var v:Vector.<GameObject>;
			
			var i:int;
			var j:int;
			for ( i = 0; i < _map.height; ++i )
			{
				v = new Vector.<GameObject>( _map.width, true );
				_tiles[ i ] = v;
				
				px = 0;
				for ( j = 0; j < _map.width; ++j )
				{
					tile = createTile( _map.isWalkable( j, i ), _tileSize );
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
			_tiles = new Vector.<Vector.<GameObject>>();
		}
		
		protected function createTile( walkable:Boolean, tileSize:int ):GameObject
		{
			// ABSTRACT
			return null;
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