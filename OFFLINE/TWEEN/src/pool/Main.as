
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pool 
{
	import flash.display.Sprite;
	
	public class Main extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			//var i1:Item = PoolItem.createItem( "test1" );
			//var i2:Item = PoolItem.createItem( "test2" );
			//var i3:Item = PoolItem.createItem( "test3" );
			//
			//trace( "-----------" );
			//PoolItem.readPool();
			//
			//i3.dispose();
			//
			//trace( "-----------" );
			//PoolItem.readPool();
			//
			//PoolItem.createItem( "test4 " );
			//
			//trace( "-----------" );
			//PoolItem.readPool();
			
			
			var a:/*Item*/Array = [];
			var n:int = 10;
			for ( var i:int; i < n; ++i )
				a.push( PoolItem.createItem( "test" + i ) );
			
			trace( "----------- Création initiale" );
			PoolItem.readPool();
			
			var item:Item;
			i = 0;
			for ( ; i < n; ++i )
				a[ i ].dispose();
			
			trace( "----------- Dispose de tout" );
			PoolItem.readPool();
			trace( "\n" );
			
			for ( i = 0; i < n; ++i )
				PoolItem.createItem( "test" + i );
			
			trace( "----------- recréation totale" );
			PoolItem.readPool();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}