
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
		
		private var _playingOnDrag:Boolean;
		private var _playState:Boolean;
		
		private var _musicManager:MusicManager;
		
		private var _bufferPercent:Number;		
		private var _beginX:Number;
		private var _endX:Number;
		
		private var _timeline:DisplayObject;
		private var _bufferBar:DisplayObject;
		private var _playingBar:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractTimeline( playingOnDrag:Boolean = true ) 
		{
			this._playingOnDrag = playingOnDrag;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			_musicManager.removeEventListener( ProgressEvent.PROGRESS, onLoadProgress );
			_musicManager.removeEventListener( MusicEvent.PLAY, onSoundPlay );
			_musicManager.removeEventListener( MusicEvent.PAUSE, onSoundPause );
			_musicManager.removeEventListener( MusicEvent.STOP, onSoundStop );
			_musicManager = null;
			
			if( _timeline ) _timeline.removeEventListener( MouseEvent.MOUSE_DOWN, onTimelinePressed );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			_musicManager = MusicManager.getInstance();
			_musicManager.addEventListener( ProgressEvent.PROGRESS, onLoadProgress, false, 0, true );
			_musicManager.addEventListener( MusicEvent.PLAY, onSoundPlay, false, 0, true );
			_musicManager.addEventListener( MusicEvent.PAUSE, onSoundPause, false, 0, true );
			_musicManager.addEventListener( MusicEvent.STOP, onSoundStop, false, 0, true );
			
			if ( _timeline && !_timeline.hasEventListener( MouseEvent.MOUSE_DOWN ) ) _timeline.addEventListener( MouseEvent.MOUSE_DOWN, onTimelinePressed, false, 0, true );
		}
		
		private function onLoadProgress( e:ProgressEvent ):void 
		{
			_bufferPercent = e.bytesLoaded / e.bytesTotal;
			refreshBufferBar();
		}
		
		private function onSoundStop(e:MusicEvent):void 
		{
			removeEventListener( Event.ENTER_FRAME, refreshPlayingBar );
			_playingBar.scaleX = 0;
		}
		
		private function onSoundPause(e:MusicEvent):void 
		{
			removeEventListener( Event.ENTER_FRAME, refreshPlayingBar );
		}
		
		private function onSoundPlay(e:MusicEvent):void 
		{
			addEventListener( Event.ENTER_FRAME, refreshPlayingBar, false, 0, true );
		}
		
		protected function onTimelinePressed( e:MouseEvent ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onTimelineReleased, false, 0, true );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true );
			
			if ( !_playingOnDrag ) 
			{
				_playState = _musicManager.isPlaying();
				_musicManager.pause();
			}
			
			_beginX = e.stageX - e.localX;
			_endX = e.stageX + ( _timeline.width - e.localX );
			
			onMouseMove( e );
		}
		
		private function onTimelineReleased(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onTimelineReleased );
			
			if( !_playingOnDrag && _playState ) _musicManager.play();
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var position:Number = e.stageX - _beginX;
			if ( position < 0 ) position = 0;
			if ( position > _timeline.width ) position = _timeline.width - 1; // -1 pour correction de bug en cas de drag jusqu'à la fin.
			
			var percent:Number = position / _timeline.width;
			if ( percent > _bufferPercent ) percent = _bufferPercent;
			_musicManager.moveTo( percent );
			refreshPlayingBar();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function refreshBufferBar():void
		{
			_bufferBar.scaleX = _bufferPercent;
		}
		
		private function refreshPlayingBar( e:Event = null ):void
		{
			_playingBar.scaleX = _musicManager.songPercent;
		}
		
		/**
		 * Set the buffer bar skin, and link it to the MusicPlayer.
		 * A buffer bar allow the user to see the load part of the song.
		 * If the buffer bar is full, then the song is fully loaded.
		 * @param	bufferBar	DisplayObject	The element which will be considered as the buffer bar.
		 */
		protected function setBufferBar( bufferBar:DisplayObject ):void
		{
			_bufferBar = bufferBar;
			_bufferBar.scaleX = 0;
		}
		
		/**
		 * Set the playing bar skin, and link it to the MusicPlayer.
		 * The playing bar indicates to the user how many percent of the song has been played.
		 * @param	playingBar	DisplayObject	The element which will be considered as the playing bar.
		 */
		protected function setPlayingBar( playingBar:DisplayObject ):void
		{
			_playingBar = playingBar;
			_playingBar.scaleX = 0;
		}
		
		/**
		 * Set the timeline container. Globaly, it contains :
		 * - A background.
		 * - A playing bar.
		 * - A buffer bar.
		 * By setting the timeline skin, you will determinate the interactive part.
		 * @param	timeline	DisplayObject	The interactive element.
		 */
		protected function setTimeline( timeline:DisplayObject ):void
		{
			_timeline = timeline;
			_timeline.addEventListener( MouseEvent.MOUSE_DOWN, onTimelinePressed, false, 0, true );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * This method has to be called to completely destroy the component.
		 */
		public function dispose():void
		{
			onRemovedFromStage( null );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_playingBar = null;
			_bufferBar = null;
			_timeline = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}