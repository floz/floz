/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.rubriques.sections 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import fr.minuit4.core.interfaces.IDisposable;
	
	public class Section extends Sprite implements IDisposable
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Section() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function activate():void
		{
			// ABSTRACT
		}
		
		public function deactivate():void
		{
			// ABSTRACT
		}
		
		public function linkTo( id:int ):void
		{
			// ABSTRACT
		}
		
		public function dispose():void
		{
			// ABSTRACT
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}