package pv3DCube 
{
	import flash.events.Event;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.view.BasicView;
	
	public class Cube1 extends BasicView
	{
		private var cube:Cube;
		
		public function Cube1() 
		{
			var mat:ColorMaterial = new ColorMaterial( 0x880000 );
			
			var ml:MaterialsList = new MaterialsList();
			ml.addMaterial( mat, "all" );
			
			cube = new Cube( ml, 200, 200, 200 );			
			scene.addChild( cube );
			
			camera.fov = 30;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			cube.yaw( ( 320 - mouseX ) * .01 );
			cube.pitch( ( 240 - mouseY ) * .01 );
			
			singleRender();
		}
		
	}
	
}