
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.scrollbars
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public interface IScrollbar 
	{
		function link( scrollTarget:DisplayObject, mask:DisplayObject ):void;
	}
	
}