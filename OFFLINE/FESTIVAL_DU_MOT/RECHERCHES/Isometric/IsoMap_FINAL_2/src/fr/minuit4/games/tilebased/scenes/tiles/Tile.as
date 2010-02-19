
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.scenes.tiles 
{
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import fr.minuit4.games.tilebased.materials.Material;
	
	public class Tile extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected const _COMMANDS:Vector.<int> = new Vector.<int>( 5, true );
		protected const _DATAS:Vector.<Number> = new Vector.<Number>( 10, true );
		
		protected var _material:Material;
		protected var _size:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Tile( material:Material, size:int = 32 ) 
		{
			this._material = material;
			this._size = size;
			
			initCommands();
			initDatas();
			
			render();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function initCommands():void
		{
			_COMMANDS[ 0 ] = GraphicsPathCommand.MOVE_TO;
			var i:int = _COMMANDS.length;
			while ( --i > 0 )
				_COMMANDS[ i ] = GraphicsPathCommand.LINE_TO;
		}
		
		protected function initDatas():void
		{
			// OVERRIDE
		}
		
		protected function applyMaterial():Boolean
		{
			if ( !material )
				return false;
			
			graphics.clear();
			graphics.drawGraphicsData( material.graphicsData );
			
			return true;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function render():void
		{
			if ( !applyMaterial() )
				return;
			
			graphics.drawPath( _COMMANDS, _DATAS );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get size():int { return _size; }
		
		public function set size(value:int):void 
		{
			_size = value;
			render();
		}
		
		public function get material():Material { return _material; }
		
		public function set material(value:Material):void 
		{
			_material = value;
			render();
		}
		
	}
	
}