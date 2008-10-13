package pv3DEarth 
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import fr.minuit4.tools.FPS;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.shaders.GouraudShader;
	import org.papervision3d.materials.shaders.ShadedMaterial;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.objects.special.ParticleField;
	import org.papervision3d.view.BasicView;
	
	public class PV3DEarth2 extends BasicView
	{
		private var _earthBmp:BitmapData;
		private var _earthMaterial:BitmapMaterial;
		private var _light:PointLight3D;
		private var _shader:GouraudShader;
		private var _sphere:Sphere;
		
		private var _counter:int;
		
		public function PV3DEarth2() 
		{
			super( 640, 320 );
			
			_earthBmp = new EarthMap( 0, 0 );
			_earthMaterial = new BitmapMaterial( _earthBmp );
			
			_light = new PointLight3D();
			_light.x = 300;
			_light.y = 300;
			
			_shader = new GouraudShader( _light, 0xffffff, 0x404040 );
			
			var shadedMaterial:ShadedMaterial = new ShadedMaterial( _earthMaterial, _shader );
			
			_sphere = new Sphere( shadedMaterial, 150, 16, 12 );
			scene.addChild( _sphere );
			
			addStars();
			
			camera.fov = 30;
			camera.target = _sphere;
			
			addChild( new FPS() );
			
			addEventListener( Event.ENTER_FRAME, onFrame );
		}
		
		private function addStars():void
		{
			var particleMat:ParticleMaterial = new ParticleMaterial( 0xffffff, 1, ParticleMaterial.SHAPE_CIRCLE);
			var stars:ParticleField = new ParticleField( particleMat, 250, 2 );
			scene.addChild( stars );
		}
		
		private function onFrame(e:Event):void 
		{
			_sphere.yaw( -1 );
			oscillateCamera();
			singleRender();
		}
		
		private function oscillateCamera():void
		{
			_counter++;
			
			camera.x = Math.sin( _counter * .02 ) * 3000;
		}
		
	}
	
}