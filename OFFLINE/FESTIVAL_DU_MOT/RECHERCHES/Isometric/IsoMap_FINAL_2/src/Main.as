
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import fr.floz.isometric.geom.IsoMath;
	import fr.floz.isometric.geom.Point3D;
	import games.core.IntPoint;
	import games.scenes.tiles.Tile;
	import games.scenes.types.RepresentationType;
	import games.scenes.World;
	
	public class Main extends Sprite 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Array = [ [ 0, 0, 0, , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0 ],
									 [ 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2 ],
									 [ 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0 ], 
									 [ 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
									 [ 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ];
		
		private var _world:World;
		private var _currentPos:Point;
		
		private var _path:Vector.<IntPoint>;
		
		private var _timer:Timer;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			_world = new World( 32, _datas, RepresentationType.ISOMETRIC );
			_world.x = ( stage.stageWidth - _world.width ) * .5;
			_world.y = ( stage.stageHeight - _world.height ) * .5;
			_world.showGrid = true;
			addChild( _world );
			
			_currentPos = new Point();
			_world.getGridTile( 0, 0 ).color = 0xff0000;
			
			_timer = new Timer( 50 );
			_timer.addEventListener( TimerEvent.TIMER, timerHandler );
			
			addEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function timerHandler(e:TimerEvent):void 
		{
			if ( _path.length == 0 )
			{
				_timer.stop();
				return;
			}
			
			_world.getGridTile( _currentPos.x, _currentPos.y ).color = 0xffffff;
			
			var p:IntPoint = _path.shift();
			var t:Tile = _world.getGridTile( p.x, p.y );
			t.color = 0xff0000;
			
			_currentPos.x = p.x;
			_currentPos.y = p.y;
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			var p:Point3D = IsoMath.screenToIso( _world.mouseX, _world.mouseY );
			
			var d:Number = getTimer();
			_path = _world.findPath( _currentPos, new Point( p.x >> 5, p.y >> 5 ) );			
			trace( getTimer() - d );
			
			if( _path )	_timer.start();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}