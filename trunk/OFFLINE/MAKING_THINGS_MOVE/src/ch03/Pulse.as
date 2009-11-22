
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ch03 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Pulse extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ball:Ball;
		private var _angle:Number = 0;
		private var _centerScale:Number = 1;
		private var _range:Number = .5;
		private var _speed:Number = .1;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Pulse() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function entreFrameHandler(e:Event):void 
		{
			_ball.scaleX = _centerScale + Math.cos( _angle ) * _range;
			_ball.scaleY = _centerScale + Math.sin( _angle ) * _range;
			_angle += _speed;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_ball = new Ball();
			_ball.x = stage.stageWidth * .5;
			_ball.y = stage.stageHeight * .5;
			addChild( _ball );
			
			addEventListener( Event.ENTER_FRAME, entreFrameHandler );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}