
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
		private var _stopButton:StopButton;
		
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
			
			_playPauseButton = new PlayPauseButton();
			_buttonsCnt.addChild( _playPauseButton );
			
			_stopButton = new StopButton();
			_stopButton.x = _playPauseButton.width + 10;
			_buttonsCnt.addChild( _stopButton );
			
			var timeline:Timeline = new Timeline();
			timeline.x = 10;
			timeline.y = 45;
			addChild( timeline );
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