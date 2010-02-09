
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.floz.isometric.geom.transformations 
{
	import fr.floz.isometric.geom.Point3D;
	
	public interface IAxonometricTransformation 
	{
		function screenToSpace( p:Point3D ):Point3D;
		function spaceToScreen( p:Point3D ):Point3D;
	}
	
}