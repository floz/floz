
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.core.renderers
{
	
	public interface IRenderable 
	{
		/**
		 * Actualise l'affichage de l'objet.
		 * @param	renderTime	Number	Le temps entre le dernier rendu et le nouveau, en millisecondes.
		 */
		function render( forceRender:Boolean = false, renderTime:Number = -1 ):void;
	}
	
}