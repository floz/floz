
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.flartoolkit.pv3D 
{
	import flash.display.Sprite;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.pv3d.FLARCamera3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	public class FLARView extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _camera:FLARCamera3D;
		private var _scene:Scene3D;
		private var _viewport:Viewport3D;
		private var _renderer:BasicRenderEngine;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function FLARView( cameraParams:FLARParam, viewPortWidth:Number = 640, viewPortHeight:Number = 480, scaleToStage:Boolean = false, interactive:Boolean = true) 
		{
			_camera = new FLARCamera3D( cameraParams );
			_scene = new Scene3D();
			
			_viewport = new Viewport3D( viewportWidth, viewportHeight, scaleToStage, interactive );
			addChild( _viewport );
			
			_renderer = new BasicRenderEngine();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function singleRender():void
		{
			_renderer.renderScene( _scene, _camera, _viewport );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get scene():Scene3D { return _scene; }
		
		public function set viewportWidth( width:Number ):void
		{
			_viewport.width = width;
		}
		
		public function get viewportWidth():Number { return _viewport.width; }
		
		public function set viewportHeight( height:Number ):void
		{
			_viewport.height = height;
		}
		
		public function get viewportHeight():Number { return _viewport.height; }
		
	}
	
}