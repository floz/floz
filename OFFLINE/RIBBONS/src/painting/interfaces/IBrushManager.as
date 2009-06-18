
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
		
		/**
		 * 
		 */
		function createInstance():void;
		
		function deleteInstance( intance:Sprite ):void;
		
		/**
		 * Update the screen with the brushes list.
		 * @param	mx
		 * @param	my
		 * @return
		 */
		function update( mx:Number, my:Number ):int;
		
		/**
		 * This method has to be called to let the brush end when the mouse is up.
		 * @param	mx	Number	The mouse x position when the mouse is released.
		 * @param	my	Number	The mouse y position when the mouse is released.
		 */
		function releaseBrushes( mx:Number, my:Number ):void;
		
		/**
		 * Add a brush to the brush list.
		 * @param	brush
		 */
		function addBrush( brush:IBrush ):void;
		
		/**
		 * Remove a brush of the Brush list.
		 * @param	brush
		 */
		function removeBrush( brush:IBrush ):void;
	}
	
}