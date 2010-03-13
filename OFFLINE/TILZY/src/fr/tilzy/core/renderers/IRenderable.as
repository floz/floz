
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.renderers
{
	
	public interface IRenderable 
	{
		/**
		 * Actualise l'affichage de l'objet.
		 * @param	forceRender	Boolean	Force le rendu.
		 */
		function render( forceRender:Boolean = false ):void;
	}
	
}