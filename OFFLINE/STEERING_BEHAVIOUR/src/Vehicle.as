
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	import flash.display.Sprite;
	
	public class Vehicle extends Sprite
	{
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		public static const WRAP:String = "wrap";
		public static const BOUNCE:String = "bounce";
		
		protected var _edgeBehaviour:String = WRAP;
		protected var _mass:Number = 1.0;
		protected var _maxSpeed:Number = 10;
		protected var _position:Vector2D;
		protected var _velocity:Vector2D;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Vehicle() 
		{
			_position = new Vector2D();
			_velocity = new Vector2D();
			draw();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		protected function draw():void
		{
			graphics.clear();
			graphics.lineStyle( 0 );
			graphics.moveTo( 10, 0 );
			graphics.lineTo( -10, 5 );
			graphics.lineTo( -10, -5 );
			graphics.lineTo( 10, 0 );
		}
		
		private function wrap():void
		{
			if ( stage )
			{
				if ( _position.x > stage.stageWidth ) _position.x = 0;
				if ( _position.x < 0 ) _position.x = stage.stageWidth;				
				if ( _position.y > stage.stageHeight ) _position.y = 0;
				if ( _position.y < 0 ) _position.y = stage.stageHeight;
			}
		}
		
		private function bounce():void
		{
			if ( stage )
			{
				if ( _position.x > stage.stageWidth )
				{
					_position.x = stage.stageWidth;
					_velocity.x *= -1;
				}
				else if ( _position.x < 0 )
				{
					_position.x = 0;
					_velocity.x *= -1;
				}
				
				if ( _position.y > stage.stageHeight )
				{
					_position.y = stage.stageHeight;
					_velocity.y *= -1;
				}
				else if ( _position.y < 0 )
				{
					_position.y = 0;
					_velocity.y *= -1;
				}
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update():void
		{
			_velocity.truncate( _maxSpeed );
			
			_position = _position.add( _velocity );
			
			if ( _edgeBehaviour == WRAP )
				wrap();
			else
				bounce();
			
			this.x = position.x;
			this.y = position.y;
			this.rotation = _velocity.angle * 180 * Math.PI;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		public function get edgeBehaviour():String { return _edgeBehaviour; }
		
		public function set edgeBehaviour(value:String):void 
		{
			_edgeBehaviour = value;
		}
		
		public function get mass():Number { return _mass; }
		
		public function set mass(value:Number):void 
		{
			_mass = value;
		}
		
		public function get maxSpeed():Number { return _maxSpeed; }
		
		public function set maxSpeed(value:Number):void 
		{
			_maxSpeed = value;
		}
		
		public function get position():Vector2D { return _position; }
		
		public function set position(value:Vector2D):void 
		{
			_position = value;
			this.x = _position.x;
			this.y = _position.y;
		}
		
		public function get velocity():Vector2D { return _velocity; }
		
		public function set velocity(value:Vector2D):void 
		{
			_velocity = value;
		}
		
		override public function get x():Number { return super.x; }
		
		override public function set x(value:Number):void 
		{
			super.x = value;
			_position.x = x;
		}
		
		override public function get y():Number { return super.y; }
		
		override public function set y(value:Number):void 
		{
			super.y = value;
			_position.y = y;
		}
		
	}
	
}