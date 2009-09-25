
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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * The AbstractNextButton class has to be extended.
	 * It's relied with the use of the AbstractMusicPlayer.
	 * 
	 * You will have to call the following method in your final Volume bar class :
	 * - setVolumeBar
	 * - setDragableBar
	 */
	public class AbstractVolumeBar extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		
		private var _beginX:Number;
		private var _endX:Number;
		
		private var _cntGlobal:Sprite;
		private var _cntBackground:Sprite;
		private var _cntDragableBar:Sprite;
		
		private var _background:DisplayObject;
		private var _dragableBar:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractVolumeBar() 
		{
			_musicManager = MusicManager.getInstance();
			
			_cntGlobal = new Sprite();
			_cntGlobal.mouseChildren = false;
			addChild( _cntGlobal );
			
			_cntBackground = new Sprite();
			_cntGlobal.addChild( _cntBackground );
			
			_cntDragableBar = new Sprite();
			_cntGlobal.addChild( _cntDragableBar );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			_musicManager.removeEventListener( MusicEvent.VOLUME_CHANGED, refreshVolumeBar );
			_musicManager = null;
			
			_cntGlobal.removeEventListener( MouseEvent.MOUSE_DOWN, onVolumeBarPressed );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true );
			
			
			_musicManager.addEventListener( MusicEvent.VOLUME_CHANGED, refreshVolumeBar, false, 0, true );
			
			_cntGlobal.addEventListener( MouseEvent.MOUSE_DOWN, onVolumeBarPressed, false, 0, true );
		}
		
		private function onVolumeBarPressed(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onVolumeBarReleased, false, 0, true );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true );
			
			_beginX = e.stageX - e.localX;
			_endX = e.stageX + ( _cntGlobal.width - e.localX );
			
			onMouseMove( e );
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var position:Number = e.stageX - _beginX;
			if ( position < 0 ) position = 0;
			if ( position > _cntGlobal.width ) position = _cntGlobal.width;
			
			var percent:Number = position / _cntGlobal.width;
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
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/**
		 * This method has to be called to completely destroy the component.
		 */
		public function dispose():void
		{
			onRemovedFromStage( null );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			_dragableBar = null;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		/**
		 * Set the dragable bar. When the volumeBar will be pressed, or when the volume whill changed,
		 * the dragable bar will automaticaly be refresh.
		 * @param	dragableBar	DisplayObject	The dragable bar.
		 */
		public function set dragableBar( dragableBar:DisplayObject ):void
		{
			_dragableBar = dragableBar;
			_cntDragableBar.addChild( _dragableBar );
		}

		public function get dragableBar():DisplayObject { return _dragableBar; }
		
		public function set background( background:DisplayObject ):void
		{
			_background = background;
			_cntBackground.addChild( _background );
		}
		public function get background():DisplayObject { return _background; }
		
	}
	
}