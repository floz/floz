package pv3DEarthBall 
{
	import flash.display.BitmapData;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.shaders.GouraudShader;
	import org.papervision3d.materials.shaders.ShadedMaterial;
	import org.papervision3d.objects.primitives.Sphere;
	
	public class Earth extends Sphere
	{
		public var velocity:Number3D;
		public var rotVel:Number3D;
		public var floor:Number = -800;
		public var bounce:Number = .98;
		public var gravity:Number = 0;
		
		public function Earth( texture:BitmapData ) 
		{
			var material:BitmapMaterial = new BitmapMaterial( texture );
			
			var light:PointLight3D = new PointLight3D();
			light.x = 300;
			light.y = 300;
			
			var shader:GouraudShader = new GouraudShader( light, 0xffffff, 0x404040 );
			var shadedMaterial:ShadedMaterial = new ShadedMaterial( material, shader )
			
			super( shadedMaterial, 150, 20, 17 );
			
			velocity = Number3D.ZERO;
			rotVel = new Number3D( 0, .5, 0 );	
		}
		
		public function update():void
		{
			velocity.multiplyEq( .99 );			
			velocity.y += gravity;
			
			this.x += velocity.x;
			this.y += velocity.y;
			this.z += velocity.z;
			
			this.rotationX += rotVel.x;
			this.rotationY += rotVel.y;
			this.rotationZ += rotVel.z;
			
			if ( this.y < floor )
			{
				y = floor;
				velocity.y *= -bounce;
				rotVel.reset( velocity.z * -.1, 0, 0 );
			}
		}
		
		public function reset():void
		{
			this.x = 0;
			this.y = 0;
			this.z = 0;
			this.rotationX = 0;
			this.rotationY = 0;
			this.rotationZ = 0;
			velocity.reset( 0, 0, 0 );
			rotVel.reset( 0, .5, 0 );
			gravity = 0;
		}
		
	}
	
}