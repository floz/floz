
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package ch03 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Waves2Angles extends Sprite
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _ball:Ball;
		private var _angleX:Number = 0;
		private var _angleY:Number = 0;
		private var _centerX:Number = 200;
		private var _centerY:Number = 200;
		private var _range:Number = 50;
		private var _xSpeed:Number = .07;
		private var _ySpeed:Number = .11;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Waves2Angles() 
		{
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function entreFrameHandler(e:Event):void 
		{
			_ball.x = _centerX + Math.cos( _angleX ) * _range;
			_ball.y = _centerY + Math.sin( _angleY ) * _range;
			_angleX += _xSpeed;
			_angleY += _ySpeed;
			
			graphics.lineTo( _ball.x, _ball.y );
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_ball = new Ball();
			_ball.x = stage.stageWidth * .5;
			_ball.y = stage.stageHeight * .5;
			graphics.lineStyle( 1, 0, 1 );
			graphics.moveTo( _ball.x, _ball.y );
			addChild( _ball );
			
			addEventListener( Event.ENTER_FRAME, entreFrameHandler );
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}