
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Engine extends MovieClip 
	{
		public static const READY_TO_LOAD:String = "ready_to_load";
		public static const MOVING:String = "moving";
		public static const ENABLE:String = "enable";
		
		private const _positions:Array = [ 
			{ x: 680, y: -100, z: 1300, rotationX: 0, rotationY: 70, rotationZ: 0 }, // Applis
			{ x: -800, y: -100, z: 1800, rotationX: 0, rotationY: -60, rotationZ: 0 }, // Vidéo
			{ x: 400, y: -100, z: 3600, rotationX: 0, rotationY: 30, rotationZ: 0 }, // Son
			{ x: -500, y: -100, z: 4800, rotationX: 0, rotationY: -30, rotationZ: 0 } ]; // Caracs
		
		private var _width:Number;
		private var _height:Number;
		
		private var _downloader:Downloader;
		private var _view:BasicView;
		private var _to:Object; // { x, y, z, rotationX, rotationY, rotationZ };
		
		private var _loadingMaterial:LoadingMaterial;
		private var _listInfos:Array; // { name:String, tooltip:String, screenshot:String };
		private var _container:DisplayObject3D;
		
		private var _rendering:Boolean;
		private var _index:int;
		
		private var _target:Plane;
		private var _focused:Boolean;
		
		private var _planes:Array;
		private var _enabled:Boolean;
		private var _count:int;
		
		public function Engine( width:Number, heigh:Number ) 
		{
			_width = width;
			_height = heigh;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// EVENTS
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_downloader = new Downloader();
			_downloader.addEventListener( Downloader.IMG_LOADED, onImgLoaded );
			
			_view = new BasicView( _width, _height, false, true, CameraType.FREE );
			_view.camera.focus = 100;
			_view.camera.zoom = 10;
			
			addChild( _view );
			
			_to = { };
			reset();
		}
		
		private function onImgLoaded(e:Event):void 
		{
			var p:Plane = _container.getChildByName( e.currentTarget.lastItemDownloaded.name ) as Plane;
			
			var bd:BitmapData = new BitmapData( 928, 455, true, 0xffffff );
			bd.draw( new GradientBackground() );
			bd.draw( Bitmap( e.currentTarget.lastItemDownloaded.content ) );
			var material:BitmapMaterial = new BitmapMaterial( bd );
			material.interactive = true;
			material.smooth = true;
			
			p.material = material;
			
			_index++;
			
			if ( _index == _view.scene.numChildren )
				_loadingMaterial.kill();
		}
		
		private function onObjetOver(e:InteractiveScene3DEvent):void { _view.buttonMode = true; }
		
		private function onObjectOut(e:InteractiveScene3DEvent):void { _view.buttonMode = false; }
		
		private function onObjectClick(e:InteractiveScene3DEvent):void 
		{
			if ( !_enabled ) return;
			
			var p:Plane = _container.getChildByName( e.currentTarget.name ) as Plane;
			
			if ( p == _target ) 
				return;
			
			_target = p;
			
			prepare();
			move();
		}
		
		private function onFrame(e:Event):void 
		{
			_view.singleRender();
		}
		
		// PRIVATE
		
		private function playIntro():void
		{
			var p:Plane;
			
			var i:int;
			var n:int = _container.numChildren;
			for ( i; i < n; i++ )
			{
				p = _planes[ i ];
				Tweener.addTween( p, 
				{
					x: _positions[ i ].x,
					y: _positions[ i ].y,
					z: _positions[ i ].z,
					rotationX: _positions[ i ].rotationX,
					rotationY: _positions[ i ].rotationY,
					rotationZ: _positions[ i ].rotationZ,
					
					time: .35,
					delay: i * .1,
					transition: "easeInOutQuad",
					onComplete: endIntro
				});				
			}
		}
		
		private function endIntro():void
		{
			_count++;
			if ( _count < 4 ) 
			{
				_enabled = true;
				dispatchEvent( new Event( Engine.ENABLE ) );
			}
		}
		
		private function prepare():void
		{
			switch ( _target.name )
			{
				case "Applications" :
				{
					_to.x = 989.1;
					_to.z = -1081.3;
					break;
				}
				case "Vidéo" :
				{
					_to.x = -1159;
					_to.z = -1592.2;
					break;
				}
				case "Son" :
				{
					_to.x = 1453.7;
					_to.z = -3316.4;
					break;
				}
				case "Caractéristiques" :
				{
					_to.x = -1967;
					_to.z = -4406.2;
					break;
				}
			}
			
			_to.y = 71.4;
			_to.rotationX = _target.rotationX;
			_to.rotationY = -1 * _target.rotationY;
			_to.rotationZ = _target.rotationZ;
		}
		
		private function back():void
		{
			Tweener.addTween( _container, {
					x: 0,
					y: 0,
					z: 0,
					rotationX: 0,
					rotationY: 0,
					rotationZ: 0,
					
					time: .5,
					transition: "easeInOutQuad",
					
					onComplete: function():void {
						_focused = false;
						move();
					}
				} );
		}
		
		// PUBLIC
		
		public function init( listInfos:Array, intro:Boolean = false ):void
		{
			_listInfos = listInfos;
			_loadingMaterial = new LoadingMaterial();
			var mam:MovieMaterial = new MovieMaterial( _loadingMaterial, true, true );
			mam.smooth = true;
			//mam.interactive = true;
			
			var p:Plane;
			_container = new DisplayObject3D( "container" );
			
			var i:int;
			var n:int = _listInfos.length;
			
			_planes = [];
			for ( i; i < n; i++ )
			{
				p = new Plane( mam, 928, 455, 2, 2 ); // 	
				p.x = 0;
				p.y = 2000;
				p.z = _positions[ i ].z;
				p.rotationX = 0;
				p.rotationY = 0;
				p.rotationZ = 0;
				p.name = _listInfos[ i ].name;
				
				_container.addChild( p );
				
				p.addEventListener( InteractiveScene3DEvent.OBJECT_OVER, onObjetOver );
				p.addEventListener( InteractiveScene3DEvent.OBJECT_OUT, onObjectOut );
				p.addEventListener( InteractiveScene3DEvent.OBJECT_CLICK, onObjectClick );
				
				_downloader.add( { name: listInfos[ i ].name, url: listInfos[ i ].preview } );
				
				_planes.push( p );
			}
			
			playIntro();
			
			_view.scene.addChild( _container );
			_downloader.load();
			
			startRendering();
			
			p = null;
		}
		
		public function startRendering():void
		{
			if ( _rendering )
				return;
				
			_rendering = true;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		public function stopRendering():void
		{
			if ( !_rendering ) 
				return;
				
			_rendering = false;
			
			removeEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		public function move():void
		{
			if ( !_focused )
			{
				Tweener.addTween( _container, {
					x: _to.x,
					y: _to.y,
					z: _to.z,
					rotationX: _to.rotationX,
					rotationY: _to.rotationY,
					rotationZ: _to.rotationZ,
					
					time: .5,
					transition: "easeInOutQuad",
					onComplete: function():void
					{
						_focused = true;
						
						dispatchEvent( new Event( Engine.READY_TO_LOAD ) );
					}
				} );
				dispatchEvent( new Event( Engine.MOVING ) );
			}
			else
			{
				back();
			}
		}
		
		public function reset():void
		{
			Tweener.addTween( _container, {
					x: 0,
					y: 0,
					z: 0,
					rotationX: 0,
					rotationY: 0,
					rotationZ: 0,
					
					time: .5,
					transition: "easeInOutQuad"
				} );
			
			_focused = false;
			_target = null;
		}
		
		public function setTarget( name:String ):void
		{
			if ( name != "Index" )
			{
				_target = _container.getChildByName( name ) as Plane;
				
				prepare();
				move();
			}
			else reset();			
		}
		
		public function getTargetName():String
		{
			if ( _target ) return _target.name;
			return "Index";
		}
		
		public function isFocused():Boolean { return _focused };
		
		public function show():void	{ _container.visible = true; }
		
		public function hide():void
		{
			_container.visible = false;
			_view.singleRender();
			_view.singleRender();
		}
		
		// GETTERS & SETTERS
		
		public function get rendering():Boolean { return _rendering; }
	}
	
}