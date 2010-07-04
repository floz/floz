
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.animation.rain 
{
	
	public class Pixel 
	{		
		public var px:int;
		public var py:int;
		public var vy:Number = 0;
		public var c:uint;
		
		public var fy:Number;
		
		public var end:Boolean;
		
		public var next:Pixel;
	}
	
}