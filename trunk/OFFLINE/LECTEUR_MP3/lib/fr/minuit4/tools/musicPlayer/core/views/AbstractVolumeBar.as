
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.core.views 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fr.minuit4.tools.musicPlayer.core.managers.MusicManager;
	import fr.minuit4.tools.musicPlayer.events.MusicEvent;
	
	public class AbstractVolumeBar extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _musicManager:MusicManager;
		private var _backgroundCnt:Sprite;
		private var _barCnt:Sprite;
		
		private var _beginX:Number;
		private var _endX:Number;
		
		private var _aVolumeBar:DisplayObject;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function AbstractVolumeBar() 
		{
			_musicManager = MusicManager.getInstance();
			_musicManager.addEventListener( MusicEvent.VOLUME_CHANGED, refreshVolumeBar );
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onVolumeBarPressed(e:MouseEvent):void 
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, onVolumeBarReleased );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			_beginX = e.stageX - e.localX;
			_endX = e.stageX + ( _barCnt.width - e.localX );
			
			onMouseMove( e );
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var position:Number = e.stageX - _beginX;
			if ( position < 0 ) position = 0;
			if ( position > _barCnt.width ) position = _barCnt.width;
			
			var percent:Number = position / _barCnt.width;
			_musicManager.setVolume( percent );
		}
		
		private function onVolumeBarReleased(e:MouseEvent):void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_backgroundCnt = new Sprite();
			addChild( _backgroundCnt );
			
			_barCnt = new Sprite();
			addChild( _barCnt );
			
			_barCnt.addEventListener( MouseEvent.MOUSE_DOWN, onVolumeBarPressed );
		}
		
		private function refreshVolumeBar( e:MusicEvent ):void
		{
			_aVolumeBar.scaleX = _musicManager.getVolume();
		}
		
		protected function addVolumeBarElement( element:DisplayObject ):void
		{
			_barCnt.addChild( element );
		}
		
		protected function addBackgroundElement( element:DisplayObject ):void
		{
			_backgroundCnt.addChild( element );
		}
		
		protected function setVolumeBar( volumeBar:DisplayObject ):void
		{
			_aVolumeBar = volumeBar;
		}
		
		protected function setVolumeBarCntX( value:Number ):void { _barCnt.x = value; }
		protected function setVolumeBarCntY( value:Number ):void { _barCnt.y = value; }
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}