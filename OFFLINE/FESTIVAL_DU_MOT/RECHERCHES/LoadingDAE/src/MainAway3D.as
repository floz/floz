
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import away3d.cameras.HoverCamera3D;
	import away3d.containers.View3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Plane;
	import away3d.primitives.Sphere;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MainAway3D extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _camera:HoverCamera3D;
		private var _view:View3D;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainAway3D() 
		{
			initAway3D();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initAway3D():void
		{
			_camera = new HoverCamera3D( { zoom: 2, focus: 100, distance: 250 } );
			
			_view = new View3D( { camera: _camera, x: 250, y: 250 } );
			addChild( _view );
			
			_camera.targetpanangle = _camera.panangle = 45;
			_camera.targettiltangle = _camera.tiltangle = 20;
			_camera.mintiltangle = -90;
			
			var mat:ColorMaterial = new ColorMaterial( 0xff00ff );
			var sphere:Sphere = new Sphere( { radius: 10, material: mat, x: 100, y: -150, bothsides: true } );
			_view.scene.addChild( sphere );
			
			_camera.hover();
			_view.render();
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}