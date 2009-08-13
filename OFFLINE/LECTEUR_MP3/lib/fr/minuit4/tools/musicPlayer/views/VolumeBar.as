
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import fr.minuit4.tools.musicPlayer.core.views.AbstractVolumeBar;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	
	public class VolumeBar extends AbstractVolumeBar
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _background:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function VolumeBar() 
		{
			_visualManager = VisualManager.getInstance();
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			drawBackground();
			drawVolumeBar();
		}
		
		private function drawBackground():void
		{
			_background = new Shape();
			var g:Graphics = _background.graphics;
			g.lineStyle( 1, _visualManager.getBackgroundElementColor(), 1, true );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, 50, 10 );
			g.endFill();
			addBackgroundElement( _background );
		}
		
		private function drawVolumeBar():void
		{
			var backgroundBar:Shape = new Shape();
			var g:Graphics = backgroundBar.graphics;
			g.lineStyle( 0, 0xffffff, 1, true );
			g.beginFill( 0x999999, 1 );
			g.drawRect( 0, 0, _background.width - 3, _background.height - 3 );
			g.endFill();
			
			var volumeBar:Shape = new Shape();
			g = volumeBar.graphics;
			g.beginFill( _visualManager.getBackgroundElementColor(), 1 );
			g.drawRect( 0, 0, _background.width - 4, _background.height - 4 );
			g.endFill();
			
			addVolumeBarElement( backgroundBar );
			addVolumeBarElement( volumeBar );
			setVolumeBar( volumeBar );
			
			setVolumeBarCntX( 1.35 );
			setVolumeBarCntY( 1.35 );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}