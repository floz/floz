/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import assets.home.AssetBarrierLeft;
	import assets.home.AssetCliff;
	import assets.home.AssetMachine;
	import assets.home.AssetPost1;
	import assets.home.AssetPost2;
	import assets.home.AssetRocks;
	import assets.home.AssetsFloor;
	import assets.home.AssetsTree;
	import aze.motion.easing.Linear;
	import aze.motion.eaze;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.sampler.getSize;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import fr.minuit4.games.tilebased.common.materials.WireColorMaterial;
	import fr.minuit4.games.tilebased.common.utils.MapDatasConverter;
	import fr.minuit4.games.tilebased.isometric.geom.IsoMath;
	import fr.minuit4.games.tilebased.isometric.objects.IsoObject;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoBox;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoPlane;
	import fr.minuit4.games.tilebased.World;
	import fr.minuit4.geom.IntPoint;
	import fr.minuit4.geom.Point3D;
	import fr.minuit4.utils.debug.FPS;
	import fr.phorm.debug.DebugButton;
	
	public class Deplacement extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _datas:Array = [[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ],
									[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ]];
		
		private var _world:World;
		private var _tree:IsoObject;
		private var _char:IsoObject;
		private var _pos:Point = new Point( 0, 0 );
		private var _lastPos:Point = new Point( 0, 0 );
		private var machine:IsoObject;
		
		private var _path:Vector.<IntPoint>;
		private var _timer:Timer;
		
		private var _running:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Deplacement() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_world = new World( 32, MapDatasConverter.fromArray( _datas ) );
			_world.showGrid = true;
			addChild( _world );
			
			var cliff:IsoObject = new IsoObject();
			cliff.addChild( new AssetCliff() );
			cliff.y -= 1;
			_world.addBackgroundObject( cliff );
			
			var floor:IsoObject = new IsoObject();
			floor.addChild( new AssetsFloor() );
			_world.addBackgroundObject( floor );
			
			_tree = new IsoObject();
			_tree.addChild( new AssetsTree() );
			_tree.setSize( 4 << 5, 4 << 5 ); // 4 << 5 ?
			_tree.x = int( 15 * 32 );
			_tree.y = int( 12 * 32 );
			_world.addMobile( _tree );
			
			var rocks:IsoObject = new IsoObject();
			rocks.addChild( new AssetRocks() );
			rocks.x = int( 18 * 32 );
			rocks.y = int( 17 * 32 );
			_world.addMobile( rocks );
			
			machine = new IsoObject();
			machine.addChild( new AssetMachine() );
			machine.x = int( 21 * 32 );
			machine.y = int( 11 * 32 );
			machine.setSize( 3 << 5, 32 );
			_world.addMobile( machine );
			
			var post1:IsoObject = new IsoObject();
			post1.addChild( new AssetPost1() );
			post1.x = int( 30 * 32 );
			post1.y = int( 21 * 32 );
			_world.addMobile( post1 );
			
			var post2:IsoObject = new IsoObject();
			post2.addChild( new AssetPost2() );
			post2.x = int( 26 * 32 );
			post2.y = int( 24 * 32 );
			_world.addMobile( post2 );
			
			var barrier:IsoObject = new IsoObject();
			barrier.addChild( new AssetBarrierLeft() );
			barrier.x = int( 28 * 32 );
			barrier.y = int( 28 * 32 );
			_world.addMobile( barrier );
			
			_char = new IsoBox( new WireColorMaterial( 0xff8a00, 1, 0x444444 ) );
			_char.x = 20 * 32;
			_char.y = 15 * 32;
			_world.addMobile( _char );
			
			_pos.x = _char.x >> 5;
			_pos.y = _char.y >> 5;
			
			addChild( new FPS() ); 
			
			var showGridButton:DebugButton = new DebugButton( "Show grid" );
			showGridButton.x = 20;
			showGridButton.y = 90;
			showGridButton.addEventListener( MouseEvent.CLICK, showGridButtonClickHandler );
			addChild( showGridButton );
			
			_timer = new Timer( 10 );
			_timer.addEventListener( TimerEvent.TIMER, timerHandler );
			
			_world.addEventListener( MouseEvent.MOUSE_DOWN, worldDownHandler );
			stage.addEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelHandler );
			
			stage.addEventListener( Event.RESIZE, resizeHandler );
			resizeHandler( null );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function worldDownHandler(e:MouseEvent):void 
		{
			//moveChar();
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			stage.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			moveChar();
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			
			_lastPos.x = -1;
			_lastPos.y = -1;
			
			moveChar();
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			if ( _path.length )
			{
				var p:IntPoint = _path.shift();				
				_char.x = p.x << 5;
				_char.y = p.y << 5;
				
				_pos.x = p.x;
				_pos.y = p.y;
				
				_world.render();
			}
		}
		
		private function showGridButtonClickHandler(e:MouseEvent):void 
		{
			_world.showGrid = !_world.showGrid;
		}
		
		private function mouseWheelHandler(e:MouseEvent):void 
		{
			if ( e.delta < 0 )
			{
				_world.scaleX =
				_world.scaleY -= .1;
			}
			else
			{
				_world.scaleX =
				_world.scaleY += .1;
			}
			
			if ( _world.scaleX < .2 )
			{
				_world.scaleX =
				_world.scaleY = .2;
			}
			else if ( _world.scaleX > 1 )
			{
				_world.scaleX =
				_world.scaleY = 1;
			}
			
			resizeHandler( null );
		}
		
		private function resizeHandler(e:Event):void 
		{
			var p:Point = _char.localToGlobal( new Point( 0, 0 ) );
			//_char.parent.localToGlobal( new Point( _char.x, _char.y ) );
			trace( "_char.parent.localToGlobal( new Point( _char.x, _char.y ) ) : " + _char.parent.localToGlobal( new Point( _char.x, _char.y ) ) );
			trace( "p : " + p );
			trace( "_world.x : " + _world.x );
			trace( "_world.y : " + _world.y );
			trace( "_char.x : " + _char.x );
			trace( "_char.y : " + _char.y );
			trace( _world.globalToLocal( new Point( _char.x, _char.y ) ) );
			trace( _world.localToGlobal( new Point( _char.x, _char.y ) ) );
			_world.x = - p.x + stage.stageWidth * .5 + _world.x;
			_world.y = - p.y + stage.stageHeight * .5 + _world.y;
			//eaze( _world ).to( .1, { x: 
			//_world.y =
			trace( "_world.x : " + _world.x );
			trace( "_world.y : " + _world.y );
			trace( "_char.x : " + _char.x );
			trace( "_char.y : " + _char.y );
			
			
			trace( "_char.localToGlobal( new Point( 0, 0 ) ) : " + _char.localToGlobal( new Point( 0, 0 ) ) );
			//_world.x = ( stage.stageWidth - _world.worldWidth * _world.scaleX ) * .5 - p.x * .5;
			//_world.y = ( stage.stageHeight - _world.worldHeight * _world.scaleY ) * .5 - p.y * .5;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function moveChar():void
		{
			var p:Point3D = IsoMath.screenToIso( _world.mouseX, _world.mouseY );
			p.x = p.x >> 5;
			p.y = p.y >> 5;
			
			//if ( ( p.x >= 0 && p.x < _datas[ 0 ].length ) && ( p.y >= 0 && p.y < _datas.length ) )
			//{			
			if ( ( p.x != _lastPos.x || p.y != _lastPos.y ) )
			{
				var d:int = getTimer();
				var v:Vector.<IntPoint> = _world.findPath( _pos, p );
				trace( getTimer() - d );
				if ( v != null ) 
				{
					_path = v;
					if ( !_running ) tween();
					
					_lastPos = p;
				}
			}				
		}
		
		private function tween():void
		{
			if ( _path.length )
			{
				_running = true;
				var p:IntPoint = _path.shift();
				eaze( _char ).to( .15, { x: ( p.x << 5 ), y: ( p.y << 5 ) } )
							 .easing( Linear.easeNone )
							 .onUpdate( update );				
				
				eaze( this ).delay( .13 ).onComplete( tween );
				
				_pos.x = p.x;
				_pos.y = p.y;
				
				
			}
			else _running = false;
		}
		
		private function update():void
		{			
			var p:Point = _char.localToGlobal( new Point( 0, 0 ) );
			
			_world.x = - p.x + stage.stageWidth * .5 + _world.x;
			_world.y = - p.y + stage.stageHeight * .5 + _world.y;
			
			_world.render();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}