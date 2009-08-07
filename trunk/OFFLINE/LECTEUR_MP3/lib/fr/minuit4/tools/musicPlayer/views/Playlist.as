
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import fr.minuit4.tools.musicPlayer.core.views.PlaylistComponent;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	
	public class Playlist extends PlaylistComponent 
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		private var _background:Shape;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Playlist() 
		{
			_visualManager = VisualManager.getInstance();
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function init():void
		{
			drawBackground();
		}
		
		private function drawBackground():void 
		{
			_background = new Shape();
			addChild( _background );
			
			var g:Graphics = _background.graphics;
			g.lineStyle( 1, _visualManager.getLinesColor() );
			g.beginFill( _visualManager.getBackgroundColor() );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth(), _visualManager.getPlaylistHeight() );
			g.endFill();
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}