
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
	import fr.minuit4.tools.musicPlayer.core.AbstractDisplay;
	
	public class Device extends AbstractDisplay
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _titleBar:Sprite;
		private var _title:TextField;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Device() 
		{
			
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		override protected function drawBackground():void 
		{
			super.drawBackground();
			
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
			g.beginFill( _visualManager.getBackgroundElementColor() );
			g.drawRect( 0, 0, _visualManager.getPlayerWidth(), 20 );
			g.endFill();
			
			var tf:TextFormat = new TextFormat( "_sans", 9, 0xffffff );
			
			_title = new TextField();
			_title.y = 2;
			_title.autoSize = TextFieldAutoSize.LEFT;
			_title.selectable = false;
			_title.defaultTextFormat = tf;
			_title.text = "MINUIT4 MUSIC PLAYER";	
			_titleBar.addChild( _title );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function build():void
		{
			while ( this.numChildren ) this.removeChildAt( 0 );
			
			drawBackground();
			drawTitlebar();
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}