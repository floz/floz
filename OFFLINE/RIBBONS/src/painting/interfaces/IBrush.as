
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
		function create():void;
		
		function paint( mx:Number, my:Number ):void;
		
		function completePainting():int;
		
		function release( mx:Number, my:Number ):void;
		
		function copy():IBrush;
		
		function dispose():void;
		
		function get released():Boolean;
		
		function set enabled( value:Boolean ):void;
	}
	
}