
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.utils 
{
	
	public class UMath 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function min( a:Number, b:Number ):Number
		{
			return a < b ? a : b;
		}
		
		public static function max( a:Number, b:Number ):Number
		{
			return a > b ? a : b;
		}
		
		public static function abs( a:Number ):Number
		{
			return a < 0 ? -a : a;
		}
		
		public static function isEven( a:int ):Boolean
		{
			return ( a & 1 ) == 0;
		}
		
		public static function isOdd( a:int ):Boolean
		{
			return ( a & 1 ) == 1;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}