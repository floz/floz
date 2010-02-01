
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.geom.transformations 
{
	import fr.floz.isometric.geom.Point3D;
	
	public class DimetricTransformation implements IAxonometricTransformation
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static const Z_CORRECT:Number = Math.cos( -Math.PI / 6 ) * Math.SQRT2;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function DimetricTransformation() 
		{
			//
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function screenToSpace( p:Point3D ):Point3D
		{
			var x:Number = p.y + p.x * .5 + p.z;
			var y:Number = p.y - p.x * .5 + p.z;
			var z:Number = p.z;
			
			return new Point3D( x, y, z );
		}
		
		public function spaceToScreen( p:Point3D ):Point3D
		{
			var x:Number = p.x - p.y;
			var y:Number = ( p.x + p.y ) * .5 - p.z;// + p.z * Z_CORRECT; dixit Keith Peters
			var z:Number = p.z;
			
			return new Point3D( x, y, z );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}