
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.events 
{
	import flash.events.Event;
	
	public class MusicEvent extends Event 
	{
		public static const STOP:String = "musicevent_stop";
		public static const PLAY:String = "musicevent_play";
		public static const PAUSE:String = "musicevent_pause";
		public static const SONG_LOADED:String = "musicevent_song_loaded";
		public static const ID3_LOADED:String = "musicevent_id3_loaded";
		public static const VOLUME_CHANGED:String = "musicevent_volume_changed";
		
		public function MusicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new MusicEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MusicEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}