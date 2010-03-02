
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import fr.minuit4.games.tilebased.common.materials.ColorMaterial;
	import fr.minuit4.games.tilebased.common.materials.WireColorMaterial;
	import fr.minuit4.games.tilebased.common.utils.MapDatasConverter;
	import fr.minuit4.games.tilebased.isometric.geom.IsoMath;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoBox;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoPlane;
	import fr.minuit4.games.tilebased.World;
	import fr.minuit4.geom.IntPoint;
	import fr.minuit4.geom.Point3D;
	
	public class Main extends Sprite 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Array = [ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
									 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ];
		
		private var _world:World;
		private var _char:IsoBox;
		private var _currentPos:Point;
		private var _timer:Timer;
		
		private var _path:Vector.<IntPoint>;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{			
			_world = new World( 32, MapDatasConverter.fromArray( _datas ) );
			_world.x = ( stage.stageWidth - _world.width ) * .5;
			_world.y = ( stage.stageHeight - _world.height ) * .5;
			_world.showGrid = true;
			addChild( _world );
			
			_char = new IsoBox( new WireColorMaterial( 0x000fff, 1, 0x111111 ) );
			//_char = new IsoPlane( new ColorMaterial( 0xff00ff )
			_world.addMobile( _char );
			
			initWalls();
			
			_world.render();
			
			_currentPos = new Point( _char.x, _char.y );
			
			_timer = new Timer( 50 );
			_timer.addEventListener( TimerEvent.TIMER, timerHandler );
			
			stage.addEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function timerHandler(e:TimerEvent):void 
		{
			var p:IntPoint = _path.shift();
			
			_char.x = p.x << 5;
			_char.y = p.y << 5;
			
			_currentPos.x = p.x;
			_currentPos.y = p.y;
			
			_world.render();
			
			if ( _path.length <= 0 )
				_timer.stop();
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			var p:Point3D = IsoMath.screenToIso( _world.mouseX, _world.mouseY );
			
			var newPath:Vector.<IntPoint> = _world.findPath( _currentPos, new Point( p.x >> 5, p.y >> 5 ) );
			
			if ( newPath )
			{
				_path = newPath;
				_timer.start();
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initWalls():void
		{
			var box:IsoBox;
			
			var material:WireColorMaterial = new WireColorMaterial( 0x444444, 1, 0x111111 );
			
			var j:int, m:int;
			var n:int = _datas.length;
			for ( var i:int; i < n; ++i )
			{
				m = _datas[ i ].length;
				for ( j = 0; j < m; ++j )
				{
					if ( _datas[ i ][ j ] == 0 ) 
						continue;
					
					box = new IsoBox( material );
					box.x = j * 32;
					box.y = i * 32;
					box.cacheAsBitmap = true;
					_world.addMobile( box );
				}
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}