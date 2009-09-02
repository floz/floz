
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
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	public class AbstractVolumeBar extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		
		private var _beginX:Number;
		private var _endX:Number;
		
		private var _volumeBar:DisplayObject;
		private var _dragableBar:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractVolumeBar() 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			_musicManager.removeEventListener( MusicEvent.VOLUME_CHANGED, refreshVolumeBar );
			_musicManager = null;
			
			if ( _volumeBar ) _volumeBar.removeEventListener( MouseEvent.MOUSE_DOWN, onVolumeBarPressed );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true );
			
			_musicManager = MusicManager.getInstance();
			_musicManager.addEventListener( MusicEvent.VOLUME_CHANGED, refreshVolumeBar, false, 0, true );
			
			if ( _volumeBar ) _volumeBar.addEventListener( MouseEvent.MOUSE_DOWN, onVolumeBarPressed, false, 0, true );
		}
		
		private function onVolumeBarPressed(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onVolumeBarReleased, false, 0, true );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true );
			
			_beginX = e.stageX - e.localX;
			_endX = e.stageX + ( _volumeBar.width - e.localX );
			
			onMouseMove( e );
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var position:Number = e.stageX - _beginX;
			if ( position < 0 ) position = 0;
			if ( position > _volumeBar.width ) position = _volumeBar.width;
			
			var percent:Number = position / _volumeBar.width;
			_musicManager.setVolume( percent );
		}
		
		private function onVolumeBarReleased(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, onVolumeBarReleased );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function refreshVolumeBar( e:MusicEvent ):void
		{
			_dragableBar.scaleX = _musicManager.getVolume();
		}
		
		/**
		 * Set the global volume bar. Generally, it contains :
		 * - A background
		 * - The dragable bar
		 * It's the interactive part of the volume bar, as it's the one which will have the MouseEvent listener.
		 * @param	volumeBar	DisplayObject	The interactive zone.
		 */
		protected function setVolumeBar( volumeBar:DisplayObject ):void
		{
			_volumeBar = volumeBar;
			_volumeBar.addEventListener( MouseEvent.MOUSE_DOWN, onVolumeBarPressed, false, 0, true );
		}
		
		/**
		 * Set the dragable bar. When the volumeBar will be pressed, or when the volume whill changed,
		 * the dragable bar will automaticaly be refresh.
		 * @param	dragableBar	DisplayObject	The dragable bar.
		 */
		protected function setDragableBar( dragableBar:DisplayObject ):void
		{
			_dragableBar = dragableBar;
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * This method has to be called to completely destroy the component.
		 */
		public function dispose():void
		{
			onRemovedFromStage( null );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_dragableBar = null;
			_volumeBar = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}