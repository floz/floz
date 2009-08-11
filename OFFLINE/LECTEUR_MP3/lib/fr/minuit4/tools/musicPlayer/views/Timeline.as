
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import fr.minuit4.tools.musicPlayer.core.views.AbstractTimeline;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	
	public class Timeline extends AbstractTimeline
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _bufferBar:Shape;
		private var _playingBar:Shape;
		
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
			drawBackground();
			drawTimeline();
			
			setBufferBar( _bufferBar );
			setPlayingBar( _playingBar );
		}
		
		private function drawBackground():void
		{
			var g:Graphics = _background.graphics;
			g.lineStyle( 1, _visualManager.getBackgroundElementColor(), 1, true );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth() - 20, 12 );
			g.endFill();
		}
		
		private function drawTimeline():void
		{
			_timelineCnt.x = _timelineCnt.y = 1.35;
			
			_bufferBar = new Shape();			
			var g:Graphics = _bufferBar.graphics;
			g.beginFill( 0x999999 );
			g.lineStyle( 0, _visualManager.getElementColor(), 1, true );
			g.drawRect( 0, 0, _background.width - 3, _background.height - 3 );
			g.endFill();
			_timelineCnt.addChild( _bufferBar );
			
			_playingBar = new Shape();
			g = _playingBar.graphics;
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, _background.width - 4, _background.height - 4 );
			g.endFill();
			_timelineCnt.addChild( _playingBar );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}