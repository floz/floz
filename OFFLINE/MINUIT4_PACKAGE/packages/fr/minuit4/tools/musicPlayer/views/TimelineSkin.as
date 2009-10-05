
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.device.Timeline;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	import flash.display.Graphics;
	import flash.display.Sprite;

	public class TimelineSkin extends Timeline
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function TimelineSkin() 
		{
			_visualManager = VisualManager.getInstance();
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			drawTimeline();
		}
		
		private function drawTimeline():void
		{			
			bufferBar = new Sprite();			
			var g:Graphics = ( bufferBar as Sprite ).graphics;
			g.beginFill( 0x999999 );
			g.lineStyle( 0, _visualManager.getElementColor(), 1, true );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth() - 20 - 2, 12 - 2 );
			g.endFill();
			
			var pb:Sprite = new Sprite();
			g = pb.graphics;
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth() - 20 - 3, 12 - 3 );
			g.endFill();
			
			playingBar = pb;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}