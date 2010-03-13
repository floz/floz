
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.common
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import fr.tilzy.common.objects.GameObject;
	import fr.tilzy.common.objects.Grid;
	import fr.tilzy.core.geom.IntPoint;
	import fr.tilzy.core.layers.Layer;
	import fr.tilzy.core.maps.Map;
	import fr.tilzy.core.paths.astar.Astar;
	import fr.tilzy.core.renderers.IRenderable;
	import fr.tilzy.core.tiles.TileDatas;
	
	public class World extends Sprite implements IRenderable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _tileSize:int;
		protected var _map:Map;
		protected var _astar:Astar;
		protected var _world:Sprite;
		protected var _grid:Grid;
		
		private var _backgroundLayer:Layer;
		private var _floorLayer:Layer;
		private var _mobilesLayer:Layer;
		private var _foregroundLayer:Layer;
		
		protected var _showGrid:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function World( tileSize:int, datas:Vector.<Vector.<TileDatas>> = null ) 
		{
			this._tileSize = tileSize;
			
			_map = new Map( datas );
			_astar = new Astar( _map );
			
			_world = new Sprite();
			addChild( _world );
			
			createLayers();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function createLayers():void
		{
			_backgroundLayer = new Layer();
			_world.addChild( _backgroundLayer );
			
			_floorLayer = new Layer();
			_world.addChild( _floorLayer );
			
			_mobilesLayer = new Layer();
			_world.addChild( _mobilesLayer );
			
			_foregroundLayer = new Layer();
			_world.addChild( _foregroundLayer );
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
		
		/**
		 * Ajoute un objet de background.
		 * Il s'agit du calque 0/3.
		 * @param	go	GameObject	L'objet à ajouter.
		 */
		public function addBackgroundObject( go:GameObject ):void
		{
			_backgroundLayer.addObject( go );
		}
		
		/**
		 * Ajoute un objet qui se trouve juste au dessus du sol, sous les mobiles.
		 * Il s'agit du calque 1/3.
		 * @param	go	GameObject	L'objet à ajouter.
		 */
		public function addFloorObject( go:GameObject ):void
		{
			_floorLayer.addObject( go );
		}
		
		/**
		 * Ajoute un objet "mobile" : tout ce qui se trouve sur le même plan que les personnages.
		 * Il s'agit du calque 2/3.
		 * @param	go	GameObject	L'objet à ajouter.
		 */
		public function addMobile( go:GameObject ):void
		{
			_mobilesLayer.addObject( go );
		}
		
		public function removeMobile( go:GameObject ):void
		{
			_mobilesLayer.removeObject( go );
		}
		
		/**
		 * Ajoute un objet au premier plan.
		 * Il s'agit du calque 3/3.
		 * @param	go	GameObject	L'objet à ajouter.
		 */
		public function addForegroundObject( go:GameObject ):void
		{
			_foregroundLayer.addObject( go );
		}
		
		/**
		 * Actualise les différents layers.
		 * A appeller lors d'un changement de profondeur d'un des objets.
		 * @param	forceRender	Boolean	Oblige tous les calques à se rafraichir, même s'ils n'ont pas détectés de changements.
		 */
		public function render( forceRender:Boolean = false ):void
		{
			_backgroundLayer.render( forceRender );			
			_floorLayer.render( forceRender );						
			_mobilesLayer.render( forceRender );
			_foregroundLayer.render( forceRender );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get datas():Vector.<Vector.<TileDatas>> { return _map.datas; }
		
		public function set datas( value:Vector.<Vector.<TileDatas>> ):void
		{
			_map.datas = value;
			_astar.update();
			
			if ( _grid )
				_grid.refresh();
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
			
			if( _grid )
				_grid.visible = _showGrid;
		}
		
	}
	
}