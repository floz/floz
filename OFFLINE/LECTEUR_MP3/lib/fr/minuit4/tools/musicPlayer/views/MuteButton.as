
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import fr.minuit4.tools.musicPlayer.core.views.AbstractMuteButton;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	
	public class MuteButton extends AbstractMuteButton
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _icon:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function MuteButton() 
		{
			_visualManager = VisualManager.getInstance();
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			drawBackground();
			drawIcon();
		}
		
		private function drawBackground():void
		{
			var background:Shape = new Shape();
			addChild( background );
			
			var g:Graphics = background.graphics;
			g.lineStyle( 0, 0, 1, true );
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, 16, 16 );
			g.endFill();
		}
		
		private function drawIcon():void
		{
			_icon = new Shape();
			_icon.x = 3;
			_icon.y = 2;
			addChild( _icon );
			
			var g:Graphics = _icon.graphics;
			g.lineStyle( 0, 0, 1, true );
			g.beginFill( _visualManager.getElementColor() );
			g.moveTo( 0, 4 );
			g.lineTo( 4, 4 );
			g.lineTo( 8, 0 );
			g.lineTo( 8, 12 );
			g.lineTo( 4, 8 );
			g.lineTo( 0, 8 );
			g.endFill();
		}
		
		override protected function switchState():void 
		{
			if ( _mute )
				_icon.alpha = .5;
			else
				_icon.alpha = 1;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}