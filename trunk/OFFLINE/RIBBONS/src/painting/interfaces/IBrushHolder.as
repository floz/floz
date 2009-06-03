
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.interfaces 
{
	import flash.display.IBitmapDrawable;
	
	public interface IBrushHolder extends IBitmapDrawable
	{
		function update( mx:Number, my:Number ):int;
		
		function releaseBrushes( mx:Number, my:Number ):void;
	}
	
}