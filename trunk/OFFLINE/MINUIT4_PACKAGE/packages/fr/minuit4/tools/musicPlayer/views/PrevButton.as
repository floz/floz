
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.device.AbstractPrevButton;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Shape;

	public class PrevButton extends AbstractPrevButton
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		private var _background:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function PrevButton() 
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
			_background = new Shape();
			addChild( _background );
			
			var g:Graphics = _background.graphics;
			g.lineStyle( 0, 0, 1, true );
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, 16, 16 );
			g.endFill();
		}
		
		private function drawIcon():void
		{
			var icon:Shape = new Shape();
			icon.x = 4;
			icon.y = 3;
			addChild( icon );
			
			var g:Graphics = icon.graphics;
			g.lineStyle( 0, 0, 1, true, LineScaleMode.NONE, CapsStyle.NONE );
			g.beginFill( _visualManager.getElementColor() );
			g.moveTo( 0, 5 );
			g.lineTo( 4, 0 );
			g.lineTo( 4, 5 );
			g.lineTo( 8, 0 );
			g.lineTo( 8, 10 );
			g.lineTo( 4, 5 );
			g.lineTo( 4, 10 );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}