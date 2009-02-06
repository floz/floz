
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v04
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import fr.minuit4.tools.FPS;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Main extends MovieClip
	{		
		public var panel:Panel;
		
		private var view:BasicView;
		private var body:Body;
		
		public function Main() 
		{
			view = new BasicView( stage.stageWidth, stage.stageHeight, false, true, CameraType.FREE );
			addChild( view );
			
			view.camera.zoom = 100;
			view.camera.focus = 10;
			
			body = new Body();
			view.scene.addChild( body );
			body.y = 100;
			body.x = 250;
			
			panel.addEventListener( Panel.AXE_CHANGE, onAxeChange );
			panel.addEventListener( Panel.FORCE_CHANGE, onForceChange );
			panel.addEventListener( Panel.OFFSET_CHANGE, onOffsetChange );
			panel.addEventListener( Panel.ROTATION_CHANGE, onRotationChange );
			panel.addEventListener( Panel.SEGMENTS_CHANGE, onSegmentsChange );
			
			addChild( new FPS() );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// EVENTS
		
		private function onAxeChange(e:Event):void 
		{
			body.applyNewAxes();			
		}
		
		private function onForceChange(e:Event):void 
		{
			body.applyNewForce();
		}
		
		private function onOffsetChange(e:Event):void 
		{
			body.applyNewOffset();			
		}
		
		private function onRotationChange(e:Event):void 
		{
			body.rotationY = Model.rotationY;
			body.rotationX = Model.rotationX;
			body.rotationZ = Model.rotationZ;
		}
		
		private function onSegmentsChange(e:Event):void 
		{
			body.rebuild();
		}
		
		private function onFrame(e:Event):void 
		{
			body.applyModifiers();
			//body.rotationY += 2.5;
			view.singleRender();
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}