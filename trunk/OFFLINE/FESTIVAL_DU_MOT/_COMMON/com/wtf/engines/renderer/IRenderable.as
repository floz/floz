
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package com.wtf.engines.renderer 
{
	
	public interface IRenderable 
	{
		/**
		 * Demande aux différents objets enregistrés de se rendre.
		 * @param	renderTime	Number	Le temps entre le dernier rendu et le nouveau, en millisecondes.
		 */
		function render( renderTime:Number ):void;
	}
	
}