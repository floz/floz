
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
		public static var segmentsW:int = 3;
		public static var segmentsH:int = 3;
		
		public static var listParts:Array = [
			{ label:"Head", data:0, plane: null, segmentsW: Model.segmentsW, segmentsH: Model.segmentsH, x: 0, y: 0, z: 0, rx: 0, ry: 0, rz: 0, attributes: [] },
			{ label:"Chest", data:1, plane: null, segmentsW: Model.segmentsW, segmentsH: Model.segmentsH, x: 0, y: 0, z: 0, rx: 0, ry: 0, rz: 0, attributes: [] },
			{ label:"LeftArm", data:2, plane: null, segmentsW: Model.segmentsW, segmentsH: Model.segmentsH, x: 0, y: 0, z: 0, rx: 0, ry: 0, rz: 0, attributes: [] },
			{ label:"RightArm", data:3, plane: null, segmentsW: Model.segmentsW, segmentsH: Model.segmentsH, x: 0, y: 0, z: 0, rx: 0, ry: 0, rz: 0, attributes: [] },
			{ label:"LeftLeg", data:4, plane: null, segmentsW: Model.segmentsW, segmentsH: Model.segmentsH, x: 0, y: 0, z: 0, rx: 0, ry: 0, rz: 0, attributes: [] },
			{ label:"RightLeg", data:5, plane: null, segmentsW: Model.segmentsW, segmentsH: Model.segmentsH, x: 0, y: 0, z: 0, rx: 0, ry: 0, rz: 0, attributes: [] } ];
		
		public static var currentPart:Object;		
		public static var currentAttribute:Object;
		
		public static var dicParts:Dictionary = new Dictionary();
		
	}
	
}