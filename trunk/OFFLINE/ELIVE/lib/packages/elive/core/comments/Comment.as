
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.core.comments 
{
	
	public class Comment 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public function text:String;
		public function date:Number;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Comment() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function config( text:String, date:Number ):void
		{
			this.text = text;
			this.date = date;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}