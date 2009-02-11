
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	import flash.utils.Dictionary;
	
	public class Model 
	{
		public static var listParts:Array = [
			{ label:"Head", data:0, attributes: [] },
			{ label:"Chest", data:1, attributes: [] },
			{ label:"LeftArm", data:2, attributes: [] },
			{ label:"RightArm", data:3, attributes: [] },
			{ label:"LeftLeg", data:4, attributes: [] },
			{ label:"RightLeg", data:5, attributes: [] } ];
		
		public static var currentPart:Object;		
		public static var currentAttribute:Object;
		
		public static var segmentsW:int = 3;
		public static var segmentsH:int = 3;		
	}
	
}