
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views.device 
{
	import fr.minuit4.tools.musicPlayer.core.events.MusicEvent;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;

	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;

	/**
	 * The AbstractNextButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * You will have to call the following method in your final Timeline class :
	 * - setBufferBar
	 * - setPlayingBar
	 * - setTimeline
	 */
	public class AbstractTimeline extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _playingOnDrag:Boolean;
		private var _playState:Boolean;
		
		private var _musicManager:MusicManager;
		
		private var _background:Shape;
		
		private var _bufferPercent:Number;		
		private var _beginX:Number;
		private var _endX:Number;
		
		private var _bufferBar:DisplayObject;
		private var _playingBar:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractTimeline( playingOnDrag:Boolean = true ) 
		{
			this._playingOnDrag = playingOnDrag;
			
			_background = new Shape();
			addChild( _background );
			
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
			
			if( _background ) _background.removeEventListener( MouseEvent.MOUSE_DOWN, onTimelinePressed );
			
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
			
			if ( _background && !_background.hasEventListener( MouseEvent.MOUSE_DOWN ) ) _background.addEventListener( MouseEvent.MOUSE_DOWN, onTimelinePressed, false, 0, true );
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
			_endX = e.stageX + ( _background.width - e.localX );
			
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
			if ( position > _background.width ) position = _background.width - 1; // -1 pour correction de bug en cas de drag jusqu'à la fin.
			
			var percent:Number = position / _background.width;
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
		
		private function buildBackground():void
		{
			var g:Graphics = _background.graphics;
			g.beginFill( 0xff00ff, 0 );
			g.drawRect( _playingBar.x, _playingBar.y, _playingBar.width, _playingBar.height );
			g.endFill();
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
			_background = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/**
		 * Set the buffer bar skin, and link it to the MusicPlayer.
		 * A buffer bar allow the user to see the load part of the song.
		 * If the buffer bar is full, then the song is fully loaded.
		 * @param	bufferBar	DisplayObject	The element which will be considered as the buffer bar.
		 */
		protected function set bufferBar( bufferBar:DisplayObject ):void
		{
			_bufferBar = bufferBar;
			_bufferBar.scaleX = 0;
			
			_elts
		}
		
		/**
		 * Set the playing bar skin, and link it to the MusicPlayer.
		 * The playing bar indicates to the user how many percent of the song has been played.
		 * @param	playingBar	DisplayObject	The element which will be considered as the playing bar.
		 */
		protected function set playingBar( playingBar:DisplayObject ):void
		{
			_playingBar = playingBar;
			_playingBar.scaleX = 0;
			
			 buildBackground();
		}
		
	}
	
}