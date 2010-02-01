
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import assets.InfosPanel_FC;
	
	public class InfoPanel extends InfosPanel_FC
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _title:String;
		private var _infos:String;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function InfoPanel() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function updateTitle():void
		{
			tfTitle.text = _title;
		}
		
		private function updateInfos():void
		{
			tfInfos.text = _infos;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get title():String { return _title; }
		
		public function set title(value:String):void 
		{
			_title = value;
			updateTitle();
		}
		
		public function get infos():String { return _infos; }
		
		public function set infos(value:String):void 
		{
			_infos = value;
			updateInfos();
		}
		
	}
	
}