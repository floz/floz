
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.tilzy.core.layers 
{
	import fr.tilzy.common.objects.GameObject;
	import fr.tilzy.core.renderers.IRenderable;
	
	public interface ILayer extends IRenderable
	{
		function addObject( object:GameObject ):void;
		function renderObject( object:GameObject ):void;
		
		function get needRender():Boolean;
		function set needRender( value:Boolean ):void;
	}
	
}