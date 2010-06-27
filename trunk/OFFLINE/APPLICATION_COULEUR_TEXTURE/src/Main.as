
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _sac:SacView;
		private var _sac2:SacView2;
		private var _colorPanel:ColorPanel;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initSac();
			initColorPanel();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function changeHandler(e:Event):void 
		{
			_sac.changeColor( _colorPanel.currentColor );
			_sac2.changeColor( _colorPanel.currentColor );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function initSac():void
		{
			_sac = new SacView();
			_sac.x = _sac.y = 10;
			addChild( _sac );
			
			_sac2 = new SacView2();
			_sac2.x = _sac.x + _sac.width + 10;
			_sac2.y = 10;
			addChild( _sac2 );
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