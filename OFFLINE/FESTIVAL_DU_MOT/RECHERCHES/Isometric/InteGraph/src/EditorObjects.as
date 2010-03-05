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
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.sampler.getSize;
	import fr.minuit4.games.tilebased.common.materials.WireColorMaterial;
	import fr.minuit4.games.tilebased.common.utils.MapDatasConverter;
	import fr.minuit4.games.tilebased.isometric.geom.IsoMath;
	import fr.minuit4.games.tilebased.isometric.objects.IsoObject;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoBox;
	import fr.minuit4.games.tilebased.isometric.objects.primitives.IsoPlane;
	import fr.minuit4.games.tilebased.World;
	import fr.minuit4.geom.Point3D;
	import fr.minuit4.utils.debug.FPS;
	//import fr.phorm.debug.DebugButton;
	
	public class EditorObjects extends Sprite
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
		private var _lastState:int;
		private var machine:IsoObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function EditorObjects() 
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
			_tree.x = 15 * 32;
			_tree.y = 12 * 32;
			_world.addMobile( _tree );
			
			var rocks:IsoObject = new IsoObject();
			rocks.addChild( new AssetRocks() );
			rocks.x = 18 * 32;
			rocks.y = 17 * 32;
			_world.addMobile( rocks );
			
			machine = new IsoObject();
			machine.addChild( new AssetMachine() );
			machine.x = 21 * 32;
			machine.y = 11 * 32;
			machine.setSize( 3 << 5, 32 );
			_world.addMobile( machine );
			
			var post1:IsoObject = new IsoObject();
			post1.addChild( new AssetPost1() );
			post1.x = 30 * 32;
			post1.y = 21 * 32;
			_world.addMobile( post1 );
			
			var post2:IsoObject = new IsoObject();
			post2.addChild( new AssetPost2() );
			post2.x = 26 * 32;
			post2.y = 24 * 32;
			_world.addMobile( post2 );
			
			var barrier:IsoObject = new IsoObject();
			barrier.addChild( new AssetBarrierLeft() );
			barrier.x = 28 * 32;
			barrier.y = 28 * 32;;
			_world.addMobile( barrier );
			
			_char = new IsoBox( new WireColorMaterial( 0xff8a00, 1, 0x444444 ) );
			_world.addMobile( _char );
			
			addChild( new FPS() ); 
			
			//var showGridButton:DebugButton = new DebugButton( "Show grid" );
			//showGridButton.x = 20;
			//showGridButton.y = 90;
			//showGridButton.addEventListener( MouseEvent.CLICK, showGridButtonClickHandler );
			//addChild( showGridButton );
			
			_world.addEventListener( MouseEvent.MOUSE_DOWN, worldDownHandler );
			stage.addEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelHandler );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			
			stage.addEventListener( Event.RESIZE, resizeHandler );
			resizeHandler( null );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function showGridButtonClickHandler(e:MouseEvent):void 
		{
			_world.showGrid = !_world.showGrid;
		}
		
		private function worldDownHandler(e:MouseEvent):void 
		{
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			stage.addEventListener( MouseEvent.MOUSE_UP, worldUpHandler );
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			var p:Point3D = IsoMath.screenToIso( _world.mouseX, _world.mouseY );
			_pos.x = p.x >> 5;
			trace( "_pos.x : " + _pos.x );
			_pos.y = p.y >> 5;
			trace( "_pos.y : " + _pos.y );
			
			if ( !( _pos.x == _lastPos.x && _pos.y == _lastPos.y ) && ( _pos.y >= 0 && _pos.y < _datas.length ) && ( _pos.x >= 0 && _pos.y < _datas[ 0 ].length ) )
				updateDatas();
		}
		
		private function worldUpHandler(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, worldUpHandler );
			removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			_world.datas = MapDatasConverter.fromArray( _datas );
			
			_lastPos.x = 
			_lastPos.y = -1;
		}
		
		private function updateDatas():void 
		{			
			_datas[ _pos.y ][ _pos.x ] = _datas[ _pos.y ][ _pos.x ] == 0 ? 2 : 0;
			
			_lastPos.x = _pos.x;
			_lastPos.y = _pos.y;
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
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			switch( e.keyCode )
			{
				case 37: _char.x -= 32; break;
				case 38: _char.y -= 32; break;
				case 39: _char.x += 32; break;
				case 40: _char.y += 32; break;
				default: traceDatas(); break;
			}
			_world.render();
			
			trace( "char : " + _char.depth );
			trace( "tree : " + _tree.depth );
			trace( "machine : " + machine.depth );
		}
		
		private function resizeHandler(e:Event):void 
		{
			_world.x = ( stage.stageWidth - _world.worldWidth * _world.scaleX ) * .5;
			_world.y = ( stage.stageHeight - _world.worldHeight * _world.scaleY ) * .5;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function traceDatas():void
		{
			trace( "tree.x : " + _tree.x + ", caseX : " + ( _tree.x >> 5 ) );
			trace( "tree.y : " + _tree.y + ", caseY : " + ( _tree.y >> 5 ) );
			
			var s:String;
			var j:int, m:int;
			var n:int = _datas.length;
			for ( var i:int; i < n; ++i )
			{
				m = _datas[ i ].length;
				s = "";
				if ( i == 0 ) s += "[";
				s += "[ ";
				for ( j = 0; j < m; ++j )
				{
					s += "" + _datas[ i ][ j ];
					if( j != m - 1 ) s += ", ";
				}
				
				s += " ]";
				if ( i != n - 1 ) s += ",";
				else s += "];";
				
				trace( s );
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}