
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	import maps.core.Node;
	import maps.IMap;
	import maps.Map;
	import maps.tiles.Tile;
	import maps.types.RepresentationType;
	import pathing.AstarAlgorithm;
	
	public class Main03 extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _map:/*Array*/Array = [ [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 ],
											[ 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0 ],
											[ 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0 ],
											[ 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0 ],
											[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
											[ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0 ],
											[ 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0 ],
											[ 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0 ],
											[ 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 ],
											[ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0 ]];
		
		private var _normalMap:Map;
		private var _isoMap:Map;
		
		private var _normalPanel:InfoPanel;
		private var _isoPanel:InfoPanel;
		
		private var _oldNormalTile:Tile;
		private var _oldIsoTile:Tile;
		
		private var _normalOver:Boolean;
		private var _isoOver:Boolean;
		private var _astar:AstarAlgorithm;
		
		private var _path:Array;
		
		private var _firstClick:Boolean = true;
		private var _start:Point = new Point();
		private var _end:Point = new Point();
		
		private var _timer:Timer;
		private var _tile:Tile;
		private var _mouseDown:Boolean;
		private var _p:Point3D;
		private var _g:Point;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main03() 
		{			
			_isoMap = new Map( _map, RepresentationType.ISOMETRIC );
			_isoMap.x = stage.stageWidth - _isoMap.width * .5 - _isoMap.width * .25;
			_isoMap.y = ( stage.stageHeight - _isoMap.height ) * .5;
			addChild( _isoMap );
			
			_astar = new AstarAlgorithm( _isoMap );
			
			initPanels();
			
			_tile = _isoMap.getTile( 0, 0 );
			_tile.selected = true;
			
			_timer = new Timer( 50 );
			_timer.addEventListener( TimerEvent.TIMER, timerHandler );
			_timer.start();
			
			_isoMap.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );	
			_isoMap.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_mouseDown = true;
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			_mouseDown = false;
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			var p:Point3D = IsoMath.screenToIso( new Point3D( _isoMap.mouseX, _isoMap.mouseY ) );
			
			if ( _firstClick )
			{
				_start = new Point( p.x >> 5, p.y >> 5 );
				_firstClick = false;
			}
			else
			{
				resetMap();
				_end = new Point( p.x >> 5, p.y >> 5 );
				
				_path = _astar.findPath( _start, _end );
				
				var t:Timer = new Timer( 50 );
				t.addEventListener( TimerEvent.TIMER, timerHandler );
				t.start();
				
				_firstClick = true;
			}
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			if ( !_path || _path.length == 0 )
				return;
			
			_tile.selected = false;
			var n:Node = _path.shift();
			_tile = _isoMap.getTile( n.x, n.y );
			_start.x = n.x;
			_start.y = n.y;
			_tile.selected = true;
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			refreshIsoPanel();
			
			if ( _mouseDown )
			{
				_p = IsoMath.screenToIso( new Point3D( _isoMap.mouseX, _isoMap.mouseY ) );
				_p.x >>= 5;
				_p.y >>= 5;
				if ( _end.x == _p.x && _end.y == _p.y ) 
					return;
				
				_end.x = _p.x;
				_end.y = _p.y;
				
				_path = _astar.findPath( _start, _end );	
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initPanels():void
		{
			_isoPanel = new InfoPanel();
			_isoPanel.x = _isoMap.x - _isoMap.width * .5;
			_isoPanel.y = _isoMap.y + _isoMap.height;
			addChild( _isoPanel );
			
			_isoPanel.title = "Iso infos :";
		}
		
		private function refreshIsoPanel():void
		{
			var p:Point3D = IsoMath.screenToIso( new Point3D( _isoMap.mouseX, _isoMap.mouseY ) );
			
			_isoPanel.infos = "x : " + ( p.x >> 5 );
			_isoPanel.infos += "\ny : " + ( p.y >> 5 );
			_isoPanel.infos += "\n\nmouseX : " + _isoMap.mouseX;
			_isoPanel.infos += "\nmouseY : " + _isoMap.mouseY;
		}
		
		private function selectTile( x:int, y:int ):void
		{
			deselectTiles();
			
			var tile:Tile = _normalMap.getTile( x, y );
			if ( tile )
			{
				_oldNormalTile = tile;
				tile.selected = true;
			}			
			
			tile = _isoMap.getTile( x, y );
			if ( tile )
			{
				_oldIsoTile = tile;
				tile.selected = true;
			}
		}
		
		private function resetMap():void
		{
			var t:Tile;
			var i:int, n:int = _map.length;
			var j:int, m:int;
			for ( i; i < n; ++i )
			{
				m = _map[ i ].length;
				for ( j = 0; j < m; ++j )
				{
					t = _isoMap.getTile( j, i );
					t.selected = false;
				}
			}
		}
		
		private function deselectTiles():void
		{
			if ( _oldNormalTile ) _oldNormalTile.selected = false;
			if ( _oldIsoTile ) _oldIsoTile.selected = false;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}