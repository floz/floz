
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.geom.transformations 
{
	import fr.minuit4.geom.Point3D;
	
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
		
		public function screenToSpace( x:Number, y:Number, z:Number ):Point3D
		{
			var px:Number = y + x * .5 + z;
			var py:Number = y - x * .5 + z;
			var pz:Number = z;
			
			return new Point3D( px, py, pz );
		}
		
		public function spaceToScreen( x:Number, y:Number, z:Number ):Point3D
		{
			var px:Number = x - y;
			var py:Number = ( x + y ) * .5 - z; // + z * Z_CORRECT; dixit Keith Peters
			var pz:Number = z;
			
			return new Point3D( px, py, pz );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}