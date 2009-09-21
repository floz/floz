
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import fr.minuit4.tools.musicPlayer.core.views.DeviceComponent;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;
	
	public class Device extends DeviceComponent
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _background:Shape;
		private var _titleBar:Sprite;
		private var _title:TextField;
		private var _buttonsCnt:Sprite;
		private var _playPauseButton:PlayPauseButton;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Device() 
		{
			_visualManager = VisualManager.getInstance();
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			drawBackground();
			drawTitlebar();
			
			_buttonsCnt = new Sprite();
			_buttonsCnt.x = 10;
			_buttonsCnt.y = 65;
			addChild( _buttonsCnt );
			
			var title:MusicTitle = new MusicTitle();
			title.x = 9;
			title.y = 25;
			addChild( title );
			title.defaultTextFormat = new TextFormat( "_sans", 9, 0x000000 );
			title.autoSize = TextFieldAutoSize.LEFT;
			
			var prevButton:PrevButton = new PrevButton();
			_buttonsCnt.addChild( prevButton );
			
			_playPauseButton = new PlayPauseButton();
			_playPauseButton.x = prevButton.width + 10;
			_buttonsCnt.addChild( _playPauseButton );
			
			var nextButton:NextButton = new NextButton();
			nextButton.x = _playPauseButton.x + _playPauseButton.width + 10;
			_buttonsCnt.addChild( nextButton );
			
			var timeline:Timeline = new Timeline();
			timeline.x = 10;
			timeline.y = 45;
			addChild( timeline );
			removeChild( timeline );
			addChild( timeline );
			
			var volumeBar:VolumeBar = new VolumeBar();
			volumeBar.x = timeline.x + timeline.width - volumeBar.width;
			volumeBar.y = 68;
			addChild( volumeBar );
			
			var muteButton:MuteButton = new MuteButton();
			muteButton.x = volumeBar.x - muteButton.width - 10;
			muteButton.y = 65;
			addChild( muteButton );
		}
		
		private function drawBackground():void 
		{
			_background = new Shape();
			addChild( _background );
			
			var g:Graphics = _background.graphics;
			g.lineStyle( 1, _visualManager.getLinesColor(), 1, true );
			g.beginFill( _visualManager.getBackgroundColor() );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth(), _visualManager.getDeviceHeight() );
			g.endFill();
		}
		
		private function drawTitlebar():void
		{
			_titleBar = new Sprite();
			addChild( _titleBar );
			
			var g:Graphics = _titleBar.graphics;
			g.lineStyle( 0, 0, 1, true );
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth(), 20 );
			g.endFill();
			
			_title = new TextField();
			_title.x = 5;
			_title.y = 2.5;
			_title.autoSize = TextFieldAutoSize.LEFT;
			_title.selectable = false;
			_title.defaultTextFormat = new TextFormat( "_sans", 9, 0xffffff );
			_title.text = "MINUIT4 MUSIC PLAYER";	
			_titleBar.addChild( _title );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}