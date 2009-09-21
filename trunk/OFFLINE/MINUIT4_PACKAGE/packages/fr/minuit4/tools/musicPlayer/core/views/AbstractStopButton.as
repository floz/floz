
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views 
{
	import flash.events.MouseEvent;
	
	/**
	 * The AbstractPrevButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * This button will stop the current song.
	 */
	public class AbstractStopButton extends ButtonComponent
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractStopButton() 
		{
			super();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		override protected function onClick(e:MouseEvent):void 
		{
			_musicManager.stop();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}