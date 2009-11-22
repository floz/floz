
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ch03 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bobbing extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ball:Ball;
		private var _centerY:Number = 200;
		private var _range:Number = 50;
		private var _angle:Number = 0;
		private var _xSpeed:Number = 1;
		private var _ySpeed:Number = .05;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Bobbing() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function entreFrameHandler(e:Event):void 
		{
			_ball.x += _xSpeed;
			_ball.y = _centerY * .5 + Math.sin( _angle ) * _range;
			_angle += _ySpeed;
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_ball = new Ball();
			_ball.x = stage.stageWidth * .5;
			addChild( _ball );
			
			addEventListener( Event.ENTER_FRAME, entreFrameHandler );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}