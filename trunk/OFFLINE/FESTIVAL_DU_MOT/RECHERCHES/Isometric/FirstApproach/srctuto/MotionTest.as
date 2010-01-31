
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
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.ui.Keyboard;
	import fr.floz.isometric.DrawIsoBox;
	import fr.floz.isometric.DrawIsoTile;
	import fr.floz.isometric.IsoWorld;
	import fr.floz.isometric.Point3D;
	import fr.minuit4.utils.debug.FPS;
	
	public class MotionTest extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		private const TILE_SIZE:int = 40;
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _world:IsoWorld;
		private var _box:DrawIsoBox;
		private var _shadow:DrawIsoTile;
		private var _speed:Number = 3;
		private var _filter:BlurFilter;
		private var _gravity:Number = 2;
		private var _friction:Number = .95;
		private var _bounce:Number = -.9;
		
		private var _max:Number = 440;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MotionTest() 
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
			
			_shadow = new DrawIsoTile( TILE_SIZE, 0x000000 );
			_shadow.alpha = .5;
			_world.addChildToFloor( _shadow );
			
			_filter = new BlurFilter();
			
			addChild( new FPS() );
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			stage.addEventListener( MouseEvent.CLICK, clickHandler );
			
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
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		private function keyUpHandler(e:KeyboardEvent):void 
		{
			_box.vx = 0;
			_box.vz = 0;
			
			removeEventListener( Event.ENTER_FRAME, boxMoveHandler );
		}
		
		private function boxMoveHandler(e:Event):void 
		{
			_box.x += _box.vx;
			_box.y += _box.vy;
			_box.z += _box.vz;
			
			_world.sort();
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			_box.vy += 2;
			_box.x += _box.vx;
			_box.y += _box.vy;
			_box.z += _box.vz;
			
			if ( _box.x > _max )
			{
				_box.x = _max;
				_box.vx *= -.8;
			}
			else if ( _box.x < 0 )
			{
				_box.x = 0;
				_box.vx *= _bounce;
			}
			
			if ( _box.z > _max )
			{
				_box.z = _max;
				_box.vz *= _bounce;
			}
			else if ( _box.z < 0 )
			{
				_box.z = 0;
				_box.vz *= _bounce;
			}
			
			if ( _box.y > 0 )
			{
				_box.y = 0;
				_box.vy *= _bounce;
			}
			
			_box.vx *= _friction;
			_box.vy *= _friction;
			_box.vz *= _friction;
			
			_shadow.x = _box.x;
			_shadow.z = _box.z;
			
			_filter.blurX = _filter.blurY = -_box.y * .25;
			_shadow.filters = [ _filter ];
			
			_world.sort();
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			_box.vx = Math.random() * TILE_SIZE - TILE_SIZE * .5;
			_box.vy = Math.random() * TILE_SIZE * 2;
			_box.vz = Math.random() * TILE_SIZE - TILE_SIZE * .5;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}