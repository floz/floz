
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.users 
{
	
	public class UserStats 
	{
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var pending:uint;
		public var current:uint;
		public var refused:uint;
		public var lost:uint;
		public var bad:uint;
		public var won:uint;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function UserStats( pending:uint, current:uint, refused:uint, lost:uint, bad:uint, won:uint ) 
		{
			this.pending = pending;
			this.current = current;
			this.refused = refused;
			this.lost = lost;
			this.bad = bad;
			this.won = won;
		}
		
	}
	
}