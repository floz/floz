
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.device.AbstractVolumeBar;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class VolumeBar extends AbstractVolumeBar
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _background:Shape;
		private var _volumeBar:Sprite;
		private var _dragableBar:Shape;
		
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
			
			// Those two functions are necessary to setup the volume bar.
			setVolumeBar( _volumeBar );
			setDragableBar( _dragableBar );
		}
		
		private function drawBackground():void
		{
			_background = new Shape();
			var g:Graphics = _background.graphics;
			g.lineStyle( 1, _visualManager.getBackgroundElementColor(), 1, true );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, 50, 10 );
			g.endFill();
			addChild( _background );
		}
		
		private function drawVolumeBar():void
		{
			_volumeBar = new Sprite();
			addChild( _volumeBar );
			_volumeBar.x = _volumeBar.y = 1.35;
			
			// NOTE: A background is needed to be able to click on the 
			// entire volume bar.
			// If no background bar is added to the volume bar container, 
			// when the volume will be at 0, you won't be able to change
			// it by pressing the bar.
			var backgroundBar:Shape = new Shape();
			var g:Graphics = backgroundBar.graphics;
			g.lineStyle( 0, 0xffffff, 1, true );
			g.beginFill( 0x999999, 1 );
			g.drawRect( 0, 0, _background.width - 3, _background.height - 3 );
			g.endFill();
			_volumeBar.addChild( backgroundBar );
			
			_dragableBar = new Shape();
			g = _dragableBar.graphics;
			g.beginFill( _visualManager.getBackgroundElementColor(), 1 );
			g.drawRect( 0, 0, _background.width - 4, _background.height - 4 );
			g.endFill();
			_volumeBar.addChild( _dragableBar );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}