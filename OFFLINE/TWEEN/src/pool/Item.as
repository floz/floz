
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package pool 
{
	
	public class Item 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var id:int;
		
		public var prev:Item;
		public var next:Item;
		
		public var name:String;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Item( id:int = -1 ) 
		{
			this.id = id;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function dispose():void
		{
			PoolItem.releaseItem( this );
		}
		
		public function reset():void
		{
			prev = null;
			next = null;
			
			this.name += " - free" ;
		}
		
		public function toString():String
		{
			return this.id.toString();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}