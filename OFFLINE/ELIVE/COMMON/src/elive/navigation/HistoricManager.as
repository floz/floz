
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package elive.navigation 
{
	
	public class HistoricManager 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private static var _allowInstanciation:Boolean;
		private static var _instance:HistoricManager;
		
		private var _navId:String;
		private var _sectionId:int;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function HistoricManager() 
		{
			if ( !_allowInstanciation ) throw new Error( "This is a Singleton class, use the getInstance method instead." );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public static function getInstance():HistoricManager
		{
			if ( !_instance )
			{
				_allowInstanciation = true; {
					_instance = new HistoricManager();
				} _allowInstanciation = false;
			}
			return _instance;
		}
		
		public function registerLastNav( navId:String, sectionId:int ):void
		{
			this._navId = navId;
			this._sectionId = sectionId;
		}
		
		public function getLastNavId():String { return this._navId; }
		public function getLastSectionId():int { return this._sectionId; }
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}