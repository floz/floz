
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
		private const SEGMENTSW:int = 0;
		private const SEGMENTSH:int = 0;
		
		private var view:BasicView;
		private var body:DisplayObject3D;
		
		public function Main04() 
		{
			view = new BasicView( stage.stageWidth, stage.stageHeight, false, true, CameraType.FREE );
			addChild( view );
			
			view.camera.zoom = 100;
			view.camera.focus = 10;
			
			body = new DisplayObject3D();
			view.scene.addChild( body );
			initBody();
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
		
		private function initBody():void
		{
			var bd:BitmapData = new BmpHead( 0, 0 );
			var m:BitmapMaterial = new BitmapMaterial( bd );
			m.oneSide = false;
			
			var head:Plane = new Plane( m, bd.width, bd.height, SEGMENTSW, SEGMENTSH );
			head.y = -bd.height * .5;
			body.addChild( head );
			
			bd = new BmpChest( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var chestWidth:Number = bd.width;
			var chestHeight:Number = bd.height;
			var chest:Plane = new Plane( m, bd.width, bd.height, SEGMENTSW, SEGMENTSH );
			chest.y = head.y * 2 - bd.height * .5;			
			body.addChild( chest );
			
			bd = new RightArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var rightArm:Plane = new Plane( m, bd.width, bd.height, SEGMENTSW, SEGMENTSH );
			rightArm.x = -chestWidth * .5 - bd.width * .5;
			rightArm.y = chest.y - bd.height / 4;
			body.addChild( rightArm );
			
			bd = new LeftArm( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var leftArm:Plane = new Plane( m, bd.width, bd.height, SEGMENTSW, SEGMENTSH );
			leftArm.x = chestWidth * .5 + bd.width * .5;
			leftArm.y = rightArm.y;
			body.addChild( leftArm );
			
			bd = new LeftLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var leftLeg:Plane = new Plane( m, bd.width, bd.height, SEGMENTSW, SEGMENTSH );
			leftLeg.y = chest.y - chestHeight * .5 - bd.height * .5;
			leftLeg.x = bd.width * .5;
			body.addChild( leftLeg );
			
			bd = new RightLeg( 0, 0 );
			m = new BitmapMaterial( bd );
			m.oneSide = false;
			var rightLeg:Plane = new Plane( m, bd.width, bd.height, SEGMENTSW, SEGMENTSH );
			rightLeg.y = chest.y - chestHeight * .5 - bd.height * .5;
			rightLeg.x = -bd.width * .5;
			body.addChild( rightLeg );
		}
		
		// PUBLIC
		
	}
	
}