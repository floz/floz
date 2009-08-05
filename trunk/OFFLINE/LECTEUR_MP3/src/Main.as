
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import fr.minuit4.tools.musicPlayer.MusicPlayer;
	
	public class Main extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var mPlayer:MusicPlayer = new MusicPlayer();
			mPlayer.x = stage.stageWidth * .5 - mPlayer.width * .5;
			mPlayer.y = stage.stageHeight * .5 - mPlayer.height * .5;
			addChild( mPlayer );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get path_xml():String { return loaderInfo.parameters[ "path_xml" ] || "assets/xml/"; }
		public function get playlist_xml():String { return loaderInfo.parameters[ "playlist_xml" ] || "playlist.xml"; }
		public function get config_xml():String { return loaderInfo.parameters[ "config_xml" ] || "config.xml"; }
		
	}
	
}