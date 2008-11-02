
/**
 * Written by :
 * @author Floz - Florian Zumbrunn
 * www.floz.fr || www.minuit-4.fr
 */
package main 
{
	
	public class Const 
	{
		// Cell status
		public static const FREE:String = "free";
		public static const BLOCKED:String = "blocked";
		public static const DESTROYABLE:String = "destroyable";
		public static const CONSUMABLE:String = "consumable";
		public static const BOMB:String = "bomb";
		
		public static const STATUS:Array = [ FREE, BLOCKED ];
		
		// Keys
		public static const LEFT:int = 37;
		public static const UP:int = 38;
		public static const RIGHT:int = 39;
		public static const DOWN:int = 40;
		public static const SPACE:int = 32;
		
		// Items
		public static const BOMB_DURATION:Number = 3000;
	}
	
}