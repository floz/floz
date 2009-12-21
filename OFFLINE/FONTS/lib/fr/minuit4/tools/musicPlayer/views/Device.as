
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package fr.minuit4.tools.musicPlayer.views 
{
	import fr.minuit4.tools.musicPlayer.core.views.DeviceComponent;
	import fr.minuit4.tools.musicPlayer.manager.VisualManager;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Device extends DeviceComponent
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _visualManager:VisualManager;
		
		private var _background:Shape;
		private var _titleBar:Sprite;
		private var _title:TextField;
		private var _buttonsCnt:Sprite;
		private var _playPauseButton:PlayPauseButtonSkin;
		
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
			
			var prevButton:PrevButtonSkin = new PrevButtonSkin();
			_buttonsCnt.addChild( prevButton );
			
			_playPauseButton = new PlayPauseButtonSkin();
			_playPauseButton.x = prevButton.width + 10;
			_buttonsCnt.addChild( _playPauseButton );
			
			var nextButton:NextButtonSkin = new NextButtonSkin();
			nextButton.x = _playPauseButton.x + _playPauseButton.width + 10;
			_buttonsCnt.addChild( nextButton );
			
			var backgroundTL:Shape = new Shape();
			backgroundTL.x = 10;
			backgroundTL.y = 45;			
			var g:Graphics = backgroundTL.graphics;
			g.lineStyle( 1, _visualManager.getBackgroundElementColor(), 1, true );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth() - 20, 12 );
			g.endFill();
			addChild( backgroundTL );
			
			var timeline:TimelineSkin = new TimelineSkin();
			timeline.x = backgroundTL.x + 1.35;
			timeline.y = backgroundTL.y + 1.35;
			addChild( timeline );
			removeChild( timeline );
			addChild( timeline );
			
			var backgroundVB:Shape = new Shape();
			g = backgroundVB.graphics;
			g.lineStyle( 1, _visualManager.getBackgroundElementColor(), 1, true );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, 50, 10 );
			g.endFill();
			backgroundVB.x = backgroundTL.x + backgroundTL.width - backgroundVB.width;
			backgroundVB.y = 68;
			addChild( backgroundVB );
			
			var volumeBar:VolumeBarSkin = new VolumeBarSkin();
			volumeBar.x = backgroundVB.x + 1.35;
			volumeBar.y = backgroundVB.y + 1.35;
			addChild( volumeBar );
			
			var muteButton:MuteUnmuteButtonSkin = new MuteUnmuteButtonSkin();
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