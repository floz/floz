
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import fr.floz.isometric.DrawIsoBox;
	import fr.floz.isometric.DrawIsoTile;
	import fr.floz.isometric.IsoWorld;
	import fr.floz.isometric.Point3D;
	
	public class CollisionTest extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const TILE_SIZE:int = 40;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _world:IsoWorld;
		private var _box:DrawIsoBox;
		private var _speed:Number = 4;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function CollisionTest() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_world = new IsoWorld();
			_world.x = stage.stageWidth * .5;
			_world.y = 100;
			addChild( _world );
			
			var j:int;
			var n:int = stage.stageWidth * .5 / TILE_SIZE;
			for ( var i:int; i < n; ++i )
			{
				for ( j = 0; j < n; ++j )
				{
					var tile:DrawIsoTile = new DrawIsoTile( TILE_SIZE, 0xcccccc );
					tile.setPosition( new Point3D( i * TILE_SIZE, 0, j * TILE_SIZE ) );
					_world.addChildToFloor( tile );
				}
			}
			
			_box = new DrawIsoBox( TILE_SIZE, 0xff0000, 20 );
			_box.x = 200;
			_box.z = 200;
			_world.addChildToWorld( _box );
			
			var newBox:DrawIsoBox = new DrawIsoBox( TILE_SIZE, 0xcccccc, 20 );
			newBox.x = 300;
			newBox.z = 300;
			newBox.walkable = false;
			_world.addChildToWorld( newBox );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			switch( e.keyCode )
			{
				case Keyboard.UP: _box.vx = -_speed; break;
				case Keyboard.DOWN: _box.vx = _speed; break;
				case Keyboard.LEFT: _box.vz = _speed; break;
				case Keyboard.RIGHT: _box.vz = -_speed; break;
			}
			
			addEventListener( Event.ENTER_FRAME, boxMoveHandler );
		}
		
		private function keyUpHandler(e:KeyboardEvent):void 
		{
			_box.vx = 0;
			_box.vz = 0;
			
			removeEventListener( Event.ENTER_FRAME, boxMoveHandler );
		}
		
		private function boxMoveHandler(e:Event):void 
		{
			if ( _world.canMove( _box ) )
			{
				_box.x += _box.vx;
				_box.y += _box.vy;
				_box.z += _box.vz;
				
				_world.sort();
			}
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}