
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.interfaces 
{
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	public interface IBrushManager extends IBitmapDrawable, IEventDispatcher
	{
		function createInstance():void;
		
		function deleteInstance( intance:Sprite ):void;
		
		function update( mx:Number, my:Number ):int;
		
		function releaseBrushes( mx:Number, my:Number ):void;
		
		function addBrush( brush:IBrush ):void;
		
		function removeBrush( brush:IBrush ):void;
	}
	
}