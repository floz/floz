﻿
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
		function update( mx:Number, my:Number ):void;
		
		function reset():void;
		
		function setColors( colors:Vector.<uint> ):void;
		
		function setAlphas( alphas:Vector.<Number> ):void;
	}
	
}