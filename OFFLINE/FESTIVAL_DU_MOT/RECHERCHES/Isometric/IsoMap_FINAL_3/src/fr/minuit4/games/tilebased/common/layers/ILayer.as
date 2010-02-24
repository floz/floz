
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.games.tilebased.common.layers 
{
	import fr.minuit4.games.core.renderers.IRenderable;
	import fr.minuit4.games.tilebased.common.objects.GameObject;
	
	public interface ILayer extends IRenderable
	{
		function addObject( object:GameObject ):void;
		function renderObject( object:GameObject ):void;
		
		function get needRender():Boolean;
		function set needRender( value:Boolean ):void;
	}
	
}