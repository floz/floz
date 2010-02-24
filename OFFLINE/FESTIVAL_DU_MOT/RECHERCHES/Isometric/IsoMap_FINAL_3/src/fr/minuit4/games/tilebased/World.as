
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import fr.minuit4.games.core.renderers.IRenderable;
	import fr.minuit4.games.tilebased.common.layers.Layer;
	import fr.minuit4.games.tilebased.common.objects.GameObject;
	import fr.minuit4.games.tilebased.core.maps.Map;
	import fr.minuit4.games.tilebased.core.paths.astar.Astar;
	import fr.minuit4.games.tilebased.core.tiles.TileDatas;
	import fr.minuit4.games.tilebased.isometric.objects.IsoGrid;
	import fr.minuit4.geom.IntPoint;
	
	public class World extends Sprite implements IRenderable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _tileSize:int;
		private var _map:Map;
		private var _astar:Astar;
		private var _world:Sprite;
		private var _grid:IsoGrid;
		private var _gridRect:Rectangle;
		
		private var _backgroundLayer:Layer;
		private var _floorLayer:Layer;
		private var _mobilesLayer:Layer;
		
		private var _showGrid:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function World( tileSize:int, datas:Vector.<Vector.<TileDatas>> = null ) 
		{
			this._tileSize = tileSize;
			
			_map = new Map( datas );
			_astar = new Astar( _map );
			
			_world = new Sprite();
			addChild( _world );
			
			_grid = new IsoGrid( _tileSize, _map );
			_grid.visible = _showGrid;
			_world.addChild( _grid );
			
			_gridRect = _world.getBounds( _grid );			
			replaceWorld();
			
			createLayers();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function replaceWorld():void
		{
			_world.x = -_gridRect.x;
		}
		
		private function createLayers():void
		{
			_backgroundLayer = new Layer();
			_world.addChild( _backgroundLayer );
			
			_floorLayer = new Layer();
			_world.addChild( _floorLayer );
			
			_mobilesLayer = new Layer();
			_world.addChild( _mobilesLayer );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * Renvoie une série de points correspondant aux tiles de la map (et non aux coordonnées)
		 * à emprunter pour arriver à destination.
		 * Le chemin renvoyé est toujours le plus court.
		 * @param	start	Point	Le point de départ.
		 * @param	end	Point	Le point d'arriver.
		 * @return	Vector.<IntPoint>	Le vecteur contenant les points du parcours.
		 */
		public function findPath( start:Point, end:Point ):Vector.<IntPoint>
		{
			return _astar.findPath( start, end );
		}
		
		public function addBackgroundItem( d:GameObject ):void
		{
			_backgroundLayer.addObject( d );
		}
		
		public function addFloorItem( d:GameObject ):void
		{
			_floorLayer.addObject( d );
		}
		
		public function addMobile( d:GameObject ):void
		{
			_mobilesLayer.addObject( d );
		}
		
		public function render( forceRender:Boolean = false, renderTime:Number = -1 ):void
		{
			_backgroundLayer.render( forceRender, renderTime );
			_floorLayer.render( forceRender, renderTime );			
			_mobilesLayer.render( forceRender, renderTime );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get datas():Vector.<Vector.<TileDatas>> { return _map.datas; }
		
		public function set datas( value:Vector.<Vector.<TileDatas>> ):void
		{
			_map.datas = value;
			
			_grid.refresh();
			_gridRect = _world.getBounds( _grid );
			
			_astar.update();
			
			replaceWorld();
		}
		
		public function get tileSize():int { return _tileSize; }
		
		public function set tileSize(value:int):void 
		{
			_tileSize = value;
		}
		
		public function get showGrid():Boolean { return _showGrid; }
		
		public function set showGrid(value:Boolean):void 
		{
			_showGrid = value;
			_grid.visible = _showGrid;
		}
		
		override public function get mouseX():Number { return ( super.mouseX + _gridRect.x ); }
		
	}
	
}