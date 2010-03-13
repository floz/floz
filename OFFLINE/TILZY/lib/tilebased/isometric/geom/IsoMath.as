
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.isometric.geom 
{
	import fr.minuit4.games.tilebased.isometric.geom.transformations.IAxonometricTransformation;
	import fr.minuit4.games.tilebased.isometric.geom.transformations.DimetricTransformation;
	import fr.minuit4.geom.Point3D;
	
	public class IsoMath 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static var axoTransform:IAxonometricTransformation = new DimetricTransformation();
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function screenToIso( x:Number = 0, y:Number = 0, z:Number = 0 ):Point3D
		{
			return axoTransform.screenToSpace( x, y, z );
		}
		
		public static function isoToScreen( x:Number = 0, y:Number = 0, z:Number = 0 ):Point3D
		{
			return axoTransform.spaceToScreen( x, y, z );
		}
		
		public static function getDepth( p:Point3D ):Number
		{
			return ( ( p.x + p.y ) * .866 - p.z * .707 );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}