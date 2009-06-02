
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.interfaces 
{
	import flash.display.IBitmapDrawable;
	
	public interface IBrush extends IBitmapDrawable
	{
		function paint( mx:Number, my:Number ):void;
		
		function completePainting():int;
		
		function reset( mx:Number, my:Number ):void;
	}
	
}