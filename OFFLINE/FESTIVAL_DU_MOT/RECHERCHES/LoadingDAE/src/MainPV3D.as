
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import away3dlite.materials.BitmapFileMaterial;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import fr.minuit4.utils.debug.FPS;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.Collada;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.parsers.Max3DS;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class MainPV3D extends BasicView
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		[Embed(source="../docs/texture_herbe.jpg")]
		private var _textureHerb:Class;
		
		private var _model:DAE;
		
		private var _mouse:Point = new Point();
		private var _mouseEnabled:Boolean;
		private var p:Plane;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainPV3D() 
		{
			super( 640, 480, true, false, CameraType.TARGET );
			
			initPV3D();
			initSurface();
			initModel();
			
			addChild( new FPS() );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, downHandler );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function modelLoadCompleteHandler(e:FileLoadEvent):void 
		{
			//_model.material = new ColorMaterial( 0xff00ff );
			_model.scale = .015;
			_model.rotationY = 45;
			_model.play();
			scene.addChild( _model );
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			//_model.rotationX += 5;
			//_model.rotationY += 5;
			//_model.rotationZ += 5;
			
			//p.z -= 5;
			//p.y -= 5;
			//trace( "p.y : " + p.y );
			//p.x -= 5;
			//trace( "p.z : " + p.z );
			singleRender();
		}
		
		private function modelLoadErrorHandler(e:FileLoadEvent):void 
		{
			trace( "erreur de chargement" );
		}
		
		private function downHandler(e:MouseEvent):void 
		{
			_mouse.x = stage.mouseX;
			_mouse.y = stage.mouseY;
			
			_mouseEnabled = true;
			
			stage.addEventListener( MouseEvent.MOUSE_UP, upHandler );
		}
		
		private function upHandler(e:MouseEvent):void 
		{
			_mouseEnabled = false;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initPV3D():void
		{
			//  this.rad = new Point(2 * Math.PI / 4, Math.PI / 30);
			//camera.y = CAMERA_DISTANCE * Math.sin(this.rad.y);
            //var _loc_1:* = CAMERA_DISTANCE * Math.cos(this.rad.y);
            //camera.x = _loc_1 * Math.cos(this.rad.x);
            //camera.z = _loc_1 * Math.sin(this.rad.x);
            //camera.fov = 30;
            //camera.zoom = 110;
			
			var rad:Point = new Point(2 * Math.PI / 4, Math.PI / 30);
			camera.y = 40 * Math.sin( rad.y );
			var tmp:Number = 40 * Math.cos( rad.y );
			camera.x = tmp * Math.cos( rad.x );
			camera.z = tmp * Math.sin( rad.x );
			//camera.focus = 100;
			//camera.zoom = 10;
			
			camera.fov = 30;
			camera.zoom = 110;
		}
		
		private function initSurface():void
		{
			var m:BitmapMaterial = new BitmapMaterial( Bitmap( new _textureHerb ).bitmapData );
			m.doubleSided = true;
			p = new Plane( m, 200, 600, 1, 1 );
			p.rotationX = -90;
			p.y -= 50;
			p.z -= 500;
			p.scale = .5;
			scene.addChild( p );
		}
		
		private function initModel():void
		{
			_model = new DAE( true, null, true );
			_model.addFileSearchPath( "dae/images/" );
			_model.addEventListener( FileLoadEvent.LOAD_COMPLETE, modelLoadCompleteHandler );
			_model.addEventListener( FileLoadEvent.LOAD_ERROR, modelLoadErrorHandler );
			_model.load( "dae/avatar.dae" );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}