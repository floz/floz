
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
	import flash.events.KeyboardEvent;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Engine extends MovieClip 
	{
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
		
		private var target:Plane;
		
		private var padding:Number;
		
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
			
			//stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch( e.keyCode )
			{
				case 37 : _container.x -= padding; break;
				case 38 : _container.y += padding; break;
				case 39 : _container.x += padding; break;
				case 40 : _container.y -= padding; break;
				case 32 : _container.z += padding; break;
				case 17 : _container.z -= padding; break;
				case 109: padding = .1; break;
				case 107: padding = .1; break;
				case 73 : padding = 1; break;
				case 79 : padding = 10; break;
				case 80 : padding = 100; break;
			}
			
			trace ( "padding : " + padding );
			
			trace ( "_container.x : " + _container.x );
			trace ( "_container.y : " + _container.y );
			trace ( "_container.z : " + _container.z );
		}
		
		private function onImgLoaded(e:Event):void 
		{
			var p:Plane = _container.getChildByName( e.currentTarget.lastItemDownloaded.name ) as Plane;
			
			var bd:BitmapData = Bitmap( e.currentTarget.lastItemDownloaded.content ).bitmapData;
			var material:BitmapMaterial = new BitmapMaterial( bd );
			material.interactive = true;
			material.smooth = true;
			
			p.material = material;
			
			_index++;
			
			if ( _index == _view.scene.numChildren )
				_loadingMaterial.kill();
		}
		
		private function onObjetOver(e:InteractiveScene3DEvent):void 
		{
			_view.buttonMode = true;
		}
		
		private function onObjectOut(e:InteractiveScene3DEvent):void 
		{
			_view.buttonMode = false;
		}
		
		private function onObjectClick(e:InteractiveScene3DEvent):void 
		{
			var p:Plane = _container.getChildByName( e.currentTarget.name ) as Plane;
			//target = p;
			
			switch ( p.name )
			{
				case "Applications" :
					trace ("Applications");
					_to.x = 989.1;
					_to.z = -1081.3;
					break;
				case "Vidéo" :
				{
					trace ("Vidéo");
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
			_to.rotationX = p.rotationX;
			_to.rotationY = -1 * p.rotationY;
			_to.rotationZ = p.rotationZ;
			
			trace ( _to.x );
			trace ( _to.y );
			trace ( _to.z );
			
			move();
		}
		
		private function onFrame(e:Event):void 
		{
			_view.singleRender();
		}
		
		// PRIVATE
		
		private function playIntro():void
		{
			trace ( "here" );
		}
		
		// PUBLIC
		
		public function init( listInfos:Array, intro:Boolean = false ):void
		{			
			_listInfos = listInfos;
			
			_loadingMaterial = new LoadingMaterial();
			var mam:MovieMaterial = new MovieMaterial( _loadingMaterial, true, true );
			mam.smooth = true;
			mam.interactive = true;
			
			var p:Plane;
			_container = new DisplayObject3D( "container" );
			
			var i:int;
			var n:int = _listInfos.length;
			
			if ( intro ) 
			{
				for ( i; i < n; i++ )
				{
					p = new Plane( mam, 928, 455, 2, 2 ); // 	
					p.x = 0;
					p.y = 0;
					p.z = 0;
					p.rotationX = 0;
					p.rotationY = 0;
					p.rotationZ = 0;
					p.name = _listInfos[ i ].name;
					
					_container.addChild( p );
					
					p.addEventListener( InteractiveScene3DEvent.OBJECT_OVER, onObjetOver );
					p.addEventListener( InteractiveScene3DEvent.OBJECT_OUT, onObjectOut );
					p.addEventListener( InteractiveScene3DEvent.OBJECT_CLICK, onObjectClick );
					
					_downloader.add( { name: listInfos[ i ].name, url: listInfos[ i ].preview } );
				}
			}
			else 
			{			
				for ( i; i < n; i++ )
				{
					p = new Plane( mam, 928, 455, 2, 2 ); // 928x455 
					p.x = _positions[ i ].x;
					p.y = _positions[ i ].y;
					p.z = _positions[ i ].z;
					p.rotationX = _positions[ i ].rotationX;
					p.rotationY = _positions[ i ].rotationY;
					p.rotationZ = _positions[ i ].rotationZ;				
					p.name = _listInfos[ i ].name;
					
					_container.addChild( p );
					
					p.addEventListener( InteractiveScene3DEvent.OBJECT_OVER, onObjetOver );
					p.addEventListener( InteractiveScene3DEvent.OBJECT_OUT, onObjectOut );
					p.addEventListener( InteractiveScene3DEvent.OBJECT_CLICK, onObjectClick );
					
					_downloader.add( { name: listInfos[ i ].name, url: listInfos[ i ].preview } );
				}
			}
			_view.scene.addChild( _container );
			_downloader.load();
			
			trace ( _container );
			trace ( _container.rotationX );
			trace ( _container.rotationY );
			trace ( _container.rotationZ );
			
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
			Tweener.addTween( _container, {
				x: _to.x,
				y: _to.y,
				z: _to.z,
				rotationX: _to.rotationX,
				rotationY: _to.rotationY,
				rotationZ: _to.rotationZ,
				
				time: .5,
				transition: "easeInOutQuad"
			} );
		}
		
		public function reset():void
		{
			_to.x = 0;
			_to.y = 0;
			_to.z = -1000;
			
			_to.rotationX = 0;
			_to.rotationY = 0;
			_to.rotationZ = 0;
		}
		
		// GETTERS & SETTERS
		
		public function get rendering():Boolean { return _rendering; }		
	}
	
}