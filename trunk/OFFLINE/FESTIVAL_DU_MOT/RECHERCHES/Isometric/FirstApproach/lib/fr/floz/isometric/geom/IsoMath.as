
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.geom 
{
	import flash.geom.Point;
	import fr.floz.isometric.geom.transformations.DimetricTransformation;
	import fr.floz.isometric.geom.transformations.IAxonometricTransformation;
	
	public class IsoMath 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public static var axoTransform:IAxonometricTransformation = new DimetricTransformation();
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function screenToIso( p:Point3D ):Point3D
		{
			return axoTransform.screenToSpace( p );
		}
		
		public static function isoToScreen( p:Point3D ):Point3D
		{
			return axoTransform.spaceToScreen( p );
		}
		
		public static function getDepth( p:Point3D ):Number
		{
			return ( ( p.x + p.y ) * .866 - p.z * .707 );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}