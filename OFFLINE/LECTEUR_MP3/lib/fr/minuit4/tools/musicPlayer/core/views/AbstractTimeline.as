
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	public class AbstractTimeline extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		
		protected var _bufferPercent:Number;
		protected var _background:Sprite;
		protected var _timelineCnt:Sprite;
		
		private var _aBufferBar:DisplayObject;
		private var _aPlayingBar:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractTimeline() 
		{
			_musicManager = MusicManager.getInstance();
			_musicManager.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_musicManager.addEventListener( MusicEvent.PLAY, onSoundPlay );
			_musicManager.addEventListener( MusicEvent.PAUSE, onSoundPause );
			_musicManager.addEventListener( MusicEvent.STOP, onSoundStop );
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onLoadProgress( e:ProgressEvent ):void 
		{
			_bufferPercent = e.bytesLoaded / e.bytesTotal;
			refreshBufferBar();
		}
		
		private function onSoundStop(e:MusicEvent):void 
		{
			removeEventListener( Event.ENTER_FRAME, refreshPlayingBar );
			_aPlayingBar.scaleX = 0;
		}
		
		private function onSoundPause(e:MusicEvent):void 
		{
			removeEventListener( Event.ENTER_FRAME, refreshPlayingBar );
		}
		
		private function onSoundPlay(e:MusicEvent):void 
		{
			addEventListener( Event.ENTER_FRAME, refreshPlayingBar );
		}
		
		protected function onTimelinePressed( e:MouseEvent ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onTimelineReleased );
			_timelineCnt.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			onMouseMove( e );
		}
		
		private function onTimelineReleased(e:MouseEvent):void 
		{
			_timelineCnt.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		private function onMouseMove( e:MouseEvent ):void 
		{
			var percent:Number = e.localX / _timelineCnt.width;
			if ( percent > _bufferPercent ) 
				return;
			
			_musicManager.moveTo( percent );
			refreshPlayingBar();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_background = new Sprite();
			addChild( _background );
			
			_timelineCnt = new Sprite();
			_timelineCnt.addEventListener( MouseEvent.MOUSE_DOWN, onTimelinePressed );
			addChild( _timelineCnt );
		}
		
		private function refreshBufferBar():void
		{
			_aBufferBar.scaleX = _bufferPercent;
		}
		
		private function refreshPlayingBar( e:Event = null ):void
		{
			_aPlayingBar.scaleX = _musicManager.songPercent;
		}
		
		protected function setBufferBar( bufferBar:DisplayObject ):void
		{
			_aBufferBar = bufferBar;
			_aBufferBar.scaleX = 0;
		}
		
		protected function setPlayingBar( playingBar:DisplayObject ):void
		{
			_aPlayingBar = playingBar;
			_aPlayingBar.scaleX = 0;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}