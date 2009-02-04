
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	public class Main04 extends MovieClip
	{
		public static const SEGMENTSW:int = 0;
		public static const SEGMENTSH:int = 0;
		
		private var view:BasicView;
		private var body:Body;
		
		public function Main04() 
		{
			view = new BasicView( stage.stageWidth, stage.stageHeight, false, true, CameraType.FREE );
			addChild( view );
			
			view.camera.zoom = 100;
			view.camera.focus = 10;
			
			body = new Body();
			view.scene.addChild( body );
			body.y = 50;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		// EVENTS
		
		private function onFrame(e:Event):void 
		{
			view.singleRender();
			body.rotationY += 2.5;
		}
		
		// PRIVATE
		
		// PUBLIC
		
	}
	
}