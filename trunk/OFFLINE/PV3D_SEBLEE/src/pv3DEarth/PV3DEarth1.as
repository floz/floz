package pv3DEarth 
{
	import flash.events.Event;
	import fr.minuit4.tools.FPS;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.view.BasicView;
	
	public class PV3DEarth1 extends BasicView
	{
		private var _sphere:Sphere;
		
		public function PV3DEarth1() 
		{
			super( 640, 480 );
			
			addChild( new FPS() );
			
			_sphere = new Sphere( null, 150, 20, 12 );
			scene.addChild( _sphere );
			
			camera.fov = 30;
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function onFrame(e:Event):void 
		{
			//_sphere.yaw( .2 );
			
			_sphere.yaw( (320 - mouseX) * .01);
			_sphere.pitch( (240 - mouseY) * .01 );
			
			singleRender();
		}
		
	}
	
}