
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.AbstractTimeline;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class Timeline extends AbstractTimeline
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _background:Shape;
		private var _bufferBar:Shape;
		private var _playingBar:Shape;
		private var _timeline:Sprite;
		
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
			
			// Those three functions call are necessary to setup the timeline.
			setBufferBar( _bufferBar );
			setPlayingBar( _playingBar );
			setTimeline( _timeline );
		}
		
		private function drawBackground():void
		{
			_background = new Shape();
			var g:Graphics = _background.graphics;
			g.lineStyle( 1, _visualManager.getBackgroundElementColor(), 1, true );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth() - 20, 12 );
			g.endFill();
			addChild( _background );
		}
		
		private function drawTimeline():void
		{
			_timeline = new Sprite();
			addChild( _timeline );
			_timeline.x = _timeline.y = 1.35;
			
			// NOTE: A timeline background is needed to be able to click on the 
			// entier timeline. The background must have the width and the height
			// of the complete timeline.
			// If no background is added, graphics bug will occur if the timeline 
			// is pressed during the buffering state.
			var timelineBackground:Shape = new Shape();
			var g:Graphics = timelineBackground.graphics;
			g.lineStyle( 0, 0xffffff, 1, true );
			g.drawRect( 0, 0, _background.width - 3, _background.height - 3 );
			g.endFill();
			_timeline.addChild( timelineBackground );
			
			_bufferBar = new Shape();			
			g = _bufferBar.graphics;
			g.beginFill( 0x999999 );
			g.lineStyle( 0, _visualManager.getElementColor(), 1, true );
			g.drawRect( 0, 0, _background.width - 3, _background.height - 3 );
			g.endFill();
			_timeline.addChild( _bufferBar );
			
			_playingBar = new Shape();
			g = _playingBar.graphics;
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, _background.width - 4, _background.height - 4 );
			g.endFill();
			_timeline.addChild( _playingBar );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}