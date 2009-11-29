
/**
 * Written by :
 * @author Floz
 * www.floz.fr || www.minuit4.fr
 */
package  
{
	
	public class Branch
	{
		
		// - CONSTS ----------------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _rotation:Number;
		private var _speed:Number = 5;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		public var x:Number;
		public var y:Number;
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		public function Branch( x:Number, y:Number ) 
		{
			this.x = x;
			this.y = y;
			
			init();
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		private function init():void
		{
			_rotation = Math.random() * 360;
		}
		
		private function getRadians( degres:Number ):Number { return degres * Math.PI / 180; }
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		public function update():void
		{
			_rotation += Math.random() - .5;
			this.x += Math.cos( _rotation ) * _speed;
			this.y += Math.sin( _rotation ) * _speed;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
	}
	
}