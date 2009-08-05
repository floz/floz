
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import flash.display.Graphics;
	import fr.minuit4.tools.musicPlayer.core.AbstractDisplay;
	
	public class Playlist extends AbstractDisplay
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Playlist() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function drawBackground():void 
		{
			super.drawBackground();
			
			var g:Graphics = _background.graphics;
			g.lineStyle( 1, _visualManager.getLinesColor() );
			g.beginFill( _visualManager.getBackgroundColor() );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth(), _visualManager.getPlaylistHeight() );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function build():void
		{
			while ( this.numChildren ) this.removeChildAt( 0 );
			
			drawBackground();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}