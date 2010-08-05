
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package core.modules 
{
	
	public class Module extends ModulePart
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		protected var _data:XML;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Module() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function onData():void
		{
			// ABSTRACT
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function execute():void
		{
			// ABSTRACT
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get data():XML { return _data; }
		
		public function set data(value:XML):void 
		{
			_data = value;
			onData();
		}
		
	}
	
}