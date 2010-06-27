
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sac:SacView;
		private var _colorPanel:ColorPanel;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			initSac();
			initColorPanel();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function changeHandler(e:Event):void 
		{
			_sac.changeColor( _colorPanel.currentColor );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initSac():void
		{
			_sac = new SacView();
			_sac.x = _sac.y = 10;
			addChild( _sac );
		}
		
		private function initColorPanel():void
		{
			_colorPanel = new ColorPanel();
			_colorPanel.x = stage.stageWidth - _colorPanel.width - 10;
			_colorPanel.y = 10;
			_colorPanel.addEventListener( Event.CHANGE, changeHandler );
			addChild( _colorPanel );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}