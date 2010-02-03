
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
	import maps.builders.MapBuilderFactory;
	import maps.tiles.ITile;
	
	public class Map extends Sprite implements IMap
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _mapDatas:Array;
		protected var _tileSize:int = 32;
		
		protected var _type:String;
		protected var _mapBuilder:IMapBuilder;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Map( mapDatas:Array, type:String = "normal" ) 
		{
			this.type = type;
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
		
		public function getTile( x:int, y:int ):ITile
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
		
		public function get type():String { return _type; }
		
		public function set type(value:String):void 
		{
			_type = value;
			
			if ( _mapBuilder ) destroyMap();
			_mapBuilder = MapBuilderFactory.createBuilder( _type );
			buildMap();
		}
		
	}
	
}