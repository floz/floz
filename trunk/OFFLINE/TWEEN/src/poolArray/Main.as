
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package poolArray 
{
	import flash.display.Sprite;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			PoolArrayItem.create( "test1" );
			var i:ItemArray =PoolArrayItem.create( "test2" );
			PoolArrayItem.create( "test3" );
			
			PoolArrayItem.readPool();
			trace( "------" );
			
			i.dispose();
			
			PoolArrayItem.readPool();
			trace( "------" );
			
			PoolArrayItem.create( "test4" );
			PoolArrayItem.create( "test5" );
			PoolArrayItem.create( "test6" );
			PoolArrayItem.create( "test7" );
			
			PoolArrayItem.readPool();
			trace( "------" );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}