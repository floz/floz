
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package maps 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import maps.builders.IMapBuilder;
	
	public class Map extends Sprite implements IMap
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _mapDatas:Array;
		protected var _tileSize:int = 32;
		
		protected var _mapBuilder:IMapBuilder;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Map( mapBuilder:IMapBuilder = null, mapDatas:Array = null ) 
		{
			this.mapBuilder = mapBuilder;
			this.mapDatas = mapDatas;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function buildMap():void
		{
			if ( !_mapDatas || !_mapBuilder ) return;
			_mapBuilder.build( this );
		}
		
		protected function destroyMap():void
		{
			while ( numChildren ) removeChildAt( 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function getTile( x:int, y:int ):Tile
		{
			return _mapBuilder.getTile( x, y );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get mapDatas():Array { return _mapDatas; }
		
		public function set mapDatas(value:Array):void 
		{
			_mapDatas = value;
			buildMap();
		}
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize( value:int ):void
		{
			_tileSize = value;
			buildMap();
		}
		
		public function get mapBuilder():IMapBuilder { return _mapBuilder; }
		
		public function set mapBuilder(value:IMapBuilder):void 
		{
			_mapBuilder = value;
			if ( !_mapBuilder ) destroyMap();
			else buildMap();
		}
		
	}
	
}