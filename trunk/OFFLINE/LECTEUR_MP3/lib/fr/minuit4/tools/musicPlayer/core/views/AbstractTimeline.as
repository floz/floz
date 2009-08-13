
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
		
		private var _bufferPercent:Number;
		private var _backgroundCnt:Sprite;
		private var _timelineCnt:Sprite;
		
		private var _beginX:Number;
		private var _endX:Number;
		
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
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			_beginX = e.stageX - e.localX;
			_endX = e.stageX + ( _timelineCnt.width - e.localX );
			
			onMouseMove( e );
		}
		
		private function onTimelineReleased(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var position:Number = e.stageX - _beginX;
			if ( position < 0 ) position = 0;
			if ( position > _timelineCnt.width ) position = _timelineCnt.width;
			
			var percent:Number = position / _timelineCnt.width;
			_musicManager.moveTo( percent );
			refreshPlayingBar();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_backgroundCnt = new Sprite();
			addChild( _backgroundCnt );
			
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
		
		protected function addTimelineElement( element:DisplayObject ):void
		{
			_timelineCnt.addChild( element );
		}
		
		protected function addBackgroundElement( element:DisplayObject ):void
		{
			_backgroundCnt.addChild( element );
		}
		
		protected function getTimelineCnt():Sprite { return _timelineCnt; }
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}