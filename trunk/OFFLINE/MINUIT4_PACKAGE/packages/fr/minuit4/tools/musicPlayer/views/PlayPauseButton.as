
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.device.AbstractPlayPauseButton;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class PlayPauseButton extends AbstractPlayPauseButton
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _background:Shape;
		private var _iconCnt:Sprite;
		private var _playIcon:Shape;
		private var _pauseIcon:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PlayPauseButton() 
		{
			_visualManager = VisualManager.getInstance();
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			drawBackground();
			drawPlayIcon();
			drawPauseIcon();
			
			_iconCnt = new Sprite();
			addChild( _iconCnt );
		}
		
		private function drawBackground():void
		{
			_background = new Shape();
			addChild( _background );
			
			var g:Graphics = _background.graphics;
			g.lineStyle( 0, 0, 1, true );
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, 16, 16 );
			g.endFill();
		}
		
		private function drawPlayIcon():void
		{
			_playIcon = new Shape();
			_playIcon.x = 5;
			_playIcon.y = 3;
			
			var g:Graphics = _playIcon.graphics;
			g.lineStyle( 0, 0, 1, true );
			g.beginFill( _visualManager.getElementColor() );
			g.moveTo( 0, 0 );
			g.lineTo( 8, 5 );
			g.lineTo( 0, 10 );
			g.endFill();
		}
		
		private function drawPauseIcon():void
		{
			_pauseIcon = new Shape();
			_pauseIcon.x = 4;
			_pauseIcon.y = 4;
			
			var g:Graphics = _pauseIcon.graphics;
			g.lineStyle( 0, 0, 1, true );
			g.beginFill( _visualManager.getElementColor() );
			g.drawRect( 0, 0, 3, 8 );
			g.endFill();
			g.beginFill( _visualManager.getElementColor() );
			g.drawRect( 5, 0, 3, 8 );
			g.endFill();
		}
		
		override protected function setPlayState():void 
		{
			while ( _iconCnt.numChildren ) _iconCnt.removeChildAt( 0 );
			_iconCnt.addChild( _playIcon );
		}
		
		override protected function setPauseState():void 
		{
			while ( _iconCnt.numChildren ) _iconCnt.removeChildAt( 0 );
			_iconCnt.addChild( _pauseIcon );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}