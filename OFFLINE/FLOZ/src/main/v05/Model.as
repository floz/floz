
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main.v05 
{
	
	public class Model 
	{
		public static var listParts:Array = [
			{ label:"Head", data:0, hist: [] },
			{ label:"Chest", data:1, hist: [] },
			{ label:"LeftArm", data:2, hist: [] },
			{ label:"RightArm", data:3, hist: [] },
			{ label:"LeftLeg", data:4, hist: [] },
			{ label:"RightLeg", data:5, hist: [] } ];
		
		public static var listModifiers:Array = [
			{ label:"Bend", data:"bend" },
			{ label:"Noise", data:"bend" },
			{ label:"Perlin", data:"bend" }	];
		
	}
	
}