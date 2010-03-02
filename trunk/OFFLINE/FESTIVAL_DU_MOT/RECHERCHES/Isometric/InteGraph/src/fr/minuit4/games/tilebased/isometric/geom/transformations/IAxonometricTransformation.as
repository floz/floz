
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.isometric.geom.transformations 
{
	import fr.minuit4.geom.Point3D;
	
	public interface IAxonometricTransformation 
	{
		function screenToSpace( x:Number, y:Number, z:Number ):Point3D;
		function spaceToScreen( x:Number, y:Number, z:Number ):Point3D;
	}
	
}