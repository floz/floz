
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	
	public class MainPool extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MainPool() 
		{
			var list:/*Pool*/Array = [];
			
			var a:Array = [ "test1", "test2", "test3", "test4", "test5", "test6", "test7" ];
			var i:int = a.length;
			while ( --i > -1 )
			{
				list.push( Pool.create( 1, 2, a[ i ] ) );
			}
			
			trace( list[ 1 ].getName() );
			
			list[ 1 ].dispose();
			
			Pool.create( 2, 4, "test8" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}