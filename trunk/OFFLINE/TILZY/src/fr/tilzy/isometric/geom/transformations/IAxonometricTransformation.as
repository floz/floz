
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.isometric.geom.transformations 
{
	import fr.tilzy.core.geom.Point3D;
	
	public interface IAxonometricTransformation 
	{
		function screenToSpace( x:Number, y:Number, z:Number ):Point3D;
		function spaceToScreen( x:Number, y:Number, z:Number ):Point3D;
	}
	
}