
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.interfaces 
{
	import flash.display.IBitmapDrawable;
	import flash.events.IEventDispatcher;
	
	public interface IBrush extends IBitmapDrawable, IEventDispatcher
	{
		function paint( mx:Number, my:Number ):void;
		
		function completePainting():int;
		
		function release( mx:Number, my:Number ):void;
		
		function copy():IBrush;
	}
	
}