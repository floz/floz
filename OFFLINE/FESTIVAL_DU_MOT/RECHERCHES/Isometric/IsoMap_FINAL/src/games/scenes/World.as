
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package games.scenes 
{
	
	public class World 
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _type:String;
		
		private var _showGrid:Boolean;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function World( type:String ) 
		{
			this._type = type;
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get type():String { return _type; }
		
		public function get showGrid():Boolean { return _showGrid; }
		
		public function set showGrid(value:Boolean):void 
		{
			_showGrid = value;
		}
		
	}
	
}