package pv3DCube 
{
	import flash.events.Event;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.view.BasicView;
	
	public class Cube2 extends BasicView
	{
		private var cube:Cube;
		
		public function Cube2() 
		{
			var matFront:BitmapMaterial = new BitmapMaterial( new BitmapFront( 0, 0 ) );
			var matRight:BitmapMaterial = new BitmapMaterial( new BitmapRight( 0, 0 ) );
			var matBack:BitmapMaterial = new BitmapMaterial( new BitmapBack( 0, 0 ) );
			var matLeft:BitmapMaterial = new BitmapMaterial( new BitmapLeft( 0, 0 ) );
			var matBottom:BitmapMaterial = new BitmapMaterial( new BitmapBottom( 0, 0 ) );
			var matTop:BitmapMaterial = new BitmapMaterial( new BitmapTop( 0, 0 ) );
			
			var ml:MaterialsList = new MaterialsList();
			ml.addMaterial( matFront, "front" );
			ml.addMaterial( matLeft, "left" );
			ml.addMaterial( matBack, "back" );
			ml.addMaterial( matRight, "right" );			
			ml.addMaterial( matTop, "top" );
			ml.addMaterial( matBottom, "bottom" );			
			
			cube = new Cube( ml, 200, 200, 200, 5, 5, 5 );
			scene.addChild( cube );
			
			camera.fov = 30;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			cube.yaw( ( 320 - mouseX ) * .01 );
			cube.pitch( ( 240 - mouseX ) * .01 );
			
			singleRender();
		}
		
	}
	
}