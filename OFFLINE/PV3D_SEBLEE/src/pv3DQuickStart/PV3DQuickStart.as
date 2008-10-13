package pv3DQuickStart 
{
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.view.BasicView;
	
	public class PV3DQuickStart extends BasicView
	{
		
		public function PV3DQuickStart() 
		{
			super( 640, 480 );
			
			var _sphere:Sphere = new Sphere( null, 150, 20, 12 );
			scene.addChild( _sphere );
			
			// Champs de vision
			camera.fov = 30;
			
			startRendering();
			// singleRender();
		}
		
	}
	
}