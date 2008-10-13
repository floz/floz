package pv3DCube 
{
	import flash.events.Event;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.special.ParticleField;
	import org.papervision3d.view.BasicView;
	
	public class Cube3 extends BasicView
	{
		private var cube:Cube;
		
		public function Cube3() 
		{
			super( 640, 480, true, false, CameraType.FREE );
			
			var matFront:BitmapMaterial = new BitmapMaterial( new BitmapFront( 0, 0 ) );
			var matRight:BitmapMaterial = new BitmapMaterial( new BitmapRight( 0, 0 ) );
			var matBack:BitmapMaterial = new BitmapMaterial( new BitmapBack( 0, 0 ) );
			var matLeft:BitmapMaterial = new BitmapMaterial( new BitmapLeft( 0, 0 ) );
			var matBottom:BitmapMaterial = new BitmapMaterial( new BitmapBottom( 0, 0 ) );
			var matTop:BitmapMaterial = new BitmapMaterial( new BitmapTop( 0, 0 ) );
			
			matFront.oneSide = false;
			matRight.oneSide = false;
			matBack.oneSide = false;
			matLeft.oneSide = false;
			matBottom.oneSide = false;
			matTop.oneSide = false;
			
			var ml:MaterialsList = new MaterialsList();
			ml.addMaterial( matFront, "front" );
			ml.addMaterial( matLeft, "left" );
			ml.addMaterial( matBack, "back" );
			ml.addMaterial( matTop, "top" );
			ml.addMaterial( matRight, "right" );			
			ml.addMaterial( matBottom, "bottom" );			
			
			cube = new Cube( ml, 10000, 10000, 10000, 5, 5, 5 );
			scene.addChild( cube );
			
			var particleMat:ParticleMaterial = new ParticleMaterial( 0xffffff, 1, ParticleMaterial.SHAPE_CIRCLE );
			var stars:ParticleField = new ParticleField( particleMat, 1000, 3 );
			scene.addChild( stars );
			
			camera.z = 0;
			
			camera.zoom = 6;
			camera.focus = 100;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			camera.yaw( ( 320 - mouseX ) * .004 );
			camera.pitch( ( 240 - mouseX ) * .002 );
			
			camera.moveForward( 4 );
			cube.x = camera.x;
			cube.y = camera.y;
			cube.z = camera.z;
			
			singleRender();
		}
		
	}
	
}