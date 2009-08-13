
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
	import fr.minuit4.tools.musicPlayer.core.views.AbstractNextButton;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	
	public class NextButton extends AbstractNextButton
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function NextButton() 
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
			var icon:Shape = new Shape();
			icon.x = 4;
			icon.y = 3;
			addChild( icon );
			
			var g:Graphics = icon.graphics;
			g.lineStyle( 0, 0, 1, true, LineScaleMode.NONE, CapsStyle.NONE );
			g.beginFill( _visualManager.getElementColor() );			
			g.moveTo( 0, 0 );
			g.lineTo( 4, 5 );
			g.lineTo( 4, 0 );
			g.lineTo( 8, 5 );
			g.lineTo( 4, 10 );
			g.lineTo( 4, 5 );
			g.lineTo( 0, 10 );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}