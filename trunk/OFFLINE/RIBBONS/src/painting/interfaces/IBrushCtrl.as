
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package painting.interfaces 
{
	import flash.events.IEventDispatcher;
	
	public interface IBrushCtrl extends IEventDispatcher
	{
		function createInstance():void;
		
		function deleteInstance( intance:IBrushHolder ):void;
		
		function update( mx:Number, my:Number ):int;
		
		function releaseBrushes( mx:Number, my:Number ):void;
		
		function addBrush( brush:IBrush ):void;
		
		function removeBrush( brush:IBrush ):void;
		
		function getBrushIndex( brush:IBrush ):int;
		
		function hasBrush( brush:IBrush ):Boolean;
	}
	
}