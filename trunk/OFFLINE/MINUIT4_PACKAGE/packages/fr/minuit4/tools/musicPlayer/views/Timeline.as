
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.device.AbstractTimeline;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	import flash.display.Graphics;
	import flash.display.Sprite;

	public class Timeline extends AbstractTimeline
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Timeline() 
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
			
			//playingBar = new Sprite();
			var pb:Sprite = new Sprite();
			g = pb.graphics;
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth() - 20 - 3, 12 - 3 );
			g.endFill();
			
			playingBar = pb;
			
			background = new Sprite();
			g = ( background as Sprite ).graphics;
			g.beginFill( 0xff00ff, 1 );
			g.drawRect( 0, 0, playingBar.width, playingBar.height);
			g.endFill();
			background.alpha = 0;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}