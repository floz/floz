
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit4.fr
 */
package main.v02 
{
	import flash.display.BitmapData;
	import org.papervision3d.core.material.TriangleMaterial;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Sphere;
	
	public class Projectile extends Sphere
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _friction:Number = .98;
		private var _shrink:Number = .02;
		private var _rotation:Number = 5;
		
		private var _enabled:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var xVel:Number = 0;
		public var yVel:Number = 0;
		public var zVel:Number = 0;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Projectile( radius:Number = 40, light:PointLight3D = null ) 
		{
			var m:TriangleMaterial;
			m = light ? new FlatShadeMaterial( light, 0x666666, Math.random() * 0xffffff ) : new WireframeMaterial( Math.random() * 0xfffffff ); 
			super( m, radius, 5, 5 );
			
			_enabled = true;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function move():void
		{
			if ( !_enabled ) 
				return;
			
			this.x += xVel;
			this.y += yVel;
			this.z += zVel;
			
			this.rotationX += _rotation;
			this.rotationY += _rotation;
			
			xVel *= _friction;
			yVel *= _friction;
			zVel *= _friction;
			
			scaleX =
			scaleZ =
			scaleY -= _shrink;
			
			if ( scaleX <= 0 ) 
			{
				_enabled = false;
				parent.removeChild( this );
			}
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}