
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
		private var _start:Point;
		private var _end:Point;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main03() 
		{
			_normalMap = new Map( _map );
			_normalMap.x = _normalMap.width * .5;
			_normalMap.y = ( stage.stageHeight - _normalMap.height ) * .5;
			addChild( _normalMap );
			
			_astar = new AstarAlgorithm( _normalMap );
			
			_isoMap = new Map( _map, RepresentationType.ISOMETRIC );
			//_isoMap.x = stage.stageWidth - _isoMap.width * .5 - _isoMap.width * .25;
			//_isoMap.y = ( stage.stageHeight - _isoMap.height ) * .5;
			//addChild( _isoMap );
			
			initPanels();
			
			//_normalMap.addEventListener( MouseEvent.ROLL_OVER, rollOverHandler );
			//_normalMap.addEventListener( MouseEvent.ROLL_OUT, rollOutHandler );
			_normalMap.addEventListener( MouseEvent.CLICK, clickHandler );
			
			_isoMap.addEventListener( MouseEvent.ROLL_OVER, rollOverHandler );
			_isoMap.addEventListener( MouseEvent.ROLL_OUT, rollOutHandler );
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case _normalMap: _normalOver = true; break;
				case _isoMap: _isoOver = true; break;
			}
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			switch( e.currentTarget )
			{
				case _normalMap: _normalOver = false; break;
				case _isoMap: _isoOver = false; break;
			}
			
			deselectTiles();
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			var mx:Number = _normalMap.mouseX;
			var my:Number = _normalMap.mouseY;
			if ( _firstClick )
			{
				_start = new Point( mx >> 5, my >> 5 );
				_firstClick = false;
			}
			else
			{
				resetMap();
				_end = new Point( mx >> 5, my >> 5 );
				
				_path = _astar.findPath( _start, _end );
				
				var t:Timer = new Timer( 50 );
				t.addEventListener( TimerEvent.TIMER, timerHandler );
				t.start();
				
				_firstClick = true;
			}
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			if ( _path.length == 0 )
			{
				Timer( e.currentTarget ).stop();
				Timer( e.currentTarget ).removeEventListener( TimerEvent.TIMER, timerHandler );
				return;
			}
			
			var n:Node = _path.shift();
			var t:Tile = _normalMap.getTile( n.x, n.y );
			t.selected = true;
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			refresh2DPanel();
			refreshIsoPanel();			
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initPanels():void
		{
			_normalPanel = new InfoPanel();
			_normalPanel.x = _normalMap.x;
			_normalPanel.y = _normalMap.y + _normalMap.height + 20;
			addChild( _normalPanel );
			
			_isoPanel = new InfoPanel();
			_isoPanel.x = _isoMap.x - _isoMap.width * .5;
			_isoPanel.y = _isoMap.y + _isoMap.height + 20;
			addChild( _isoPanel );
			
			_normalPanel.title = "2D infos :";
			_isoPanel.title = "Iso infos :";
		}
		
		private function refresh2DPanel():void
		{
			var mx:Number = _normalMap.mouseX;
			var my:Number = _normalMap.mouseY;
			
			_normalPanel.infos = "x : " + ( mx >> 5 );
			_normalPanel.infos += "\ny : " + ( my >> 5 );
			_normalPanel.infos += "\n\nmouseX : " + mx;
			_normalPanel.infos += "\nmouseY : " + my;
			
			if( _normalOver ) selectTile( mx >> 5, my >> 5 );
		}
		
		private function refreshIsoPanel():void
		{
			var p:Point3D = IsoMath.screenToIso( new Point3D( _isoMap.mouseX, _isoMap.mouseY ) );
			
			_isoPanel.infos = "x : " + ( p.x >> 5 );
			_isoPanel.infos += "\ny : " + ( p.y >> 5 );
			_isoPanel.infos += "\n\nmouseX : " + _isoMap.mouseX;
			_isoPanel.infos += "\nmouseY : " + _isoMap.mouseY;
			
			if( _isoOver ) selectTile( p.x >> 5, p.y >> 5 );
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
					t = _normalMap.getTile( j, i );
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