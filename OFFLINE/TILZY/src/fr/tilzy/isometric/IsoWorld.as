
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.isometric 
{
	import flash.geom.Rectangle;
	import fr.tilzy.common.World;
	import fr.tilzy.core.tiles.TileDatas;
	import fr.tilzy.isometric.objects.IsoGrid;
	
	public class IsoWorld extends World
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _gridRect:Rectangle;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function IsoWorld( tileSize:int, datas:Vector.<Vector.<TileDatas>> = null ) 
		{
			super( tileSize, datas );
			
			_grid = new IsoGrid( _tileSize, _map );
			_grid.visible = showGrid;
			_world.addChild( _grid );
			
			_gridRect = _world.getBounds( _grid );
			replaceWorld();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function replaceWorld():void
		{
			_world.x = - _gridRect.x;
			_world.x = int( _world.x );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		override public function set datas(value:Vector.<Vector.<TileDatas>>):void 
		{
			super.datas = value;
			
			_gridRect = _world.getBounds( _grid );
			replaceWorld();
		}
		
		override public function get mouseX():Number { return ( super.mouseX + _gridRect.x ); }
		
	}
	
}