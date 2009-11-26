
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package emagicien.elements 
{
	import assets.window.Battant_FC;
	import assets.Window_FC;
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Window extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _window:Window_FC;
		private var _battant:Battant_FC;
		private var _duration1:Number;
		private var _duration2:Number;
		
		private var _canvas:BitmapData;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Window() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			construct();
			_duration1 = 158 / 50;
			_duration2 = 20 / 50;
			
			_battant = new Battant_FC();
		}
		
		private function onExplosion():void
		{
			TweenMax.to( _window, .2, { frame: _window.totalFrames, ease: Linear.easeIn } );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function explode():void
		{
			trace( _window.totalFrames );
			TweenMax.to( _window, 3, { frame: 158, onComplete: onExplosion, ease: Linear.easeIn } );
		}
		
		public function construct():void
		{
			while ( numChildren ) removeChildAt( 0 );			
			_window = new Window_FC();
			addChild( _window );
			
			_canvas = new BitmapData( _battant.width, _battant.height, true, 0xff00ff );
			addChild( new Bitmap( _canvas ) );
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}