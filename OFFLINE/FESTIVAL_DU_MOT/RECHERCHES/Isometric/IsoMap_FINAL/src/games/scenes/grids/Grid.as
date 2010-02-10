
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes.grids 
{
	import flash.display.Sprite;
	
	public class Grid extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _datas:Array;
		private var _type:String;
		
		private var _tiles:Sprite;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Grid( tileSize:int, datas:Array, type:String ) 
		{
			this._tileSize = tileSize;
			this._datas = datas;
			this._type = type;
			
			_tiles = new Sprite();
			addChild( _tiles );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function build():void
		{
			destroy();
		}
		
		protected function destroy():void
		{
			while ( _tiles.numChildren ) _tiles.removeChildAt( 0 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize(value:int):void 
		{
			_tileSize = value;
			build();
		}
		
	}
	
}